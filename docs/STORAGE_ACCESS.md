# Horus Storage Access Contract

This contract describes the buckets provisioned by migration
`20260928180000_storage_access.sql`. All Storage object access is enforced by
RLS on `storage.objects`; path segments are checked against `auth.uid()` or
canonical database relationships. A client-supplied owner ID, role, object
metadata, or MIME header does not grant authorization.

## Bucket matrix

| Bucket | Public | Object path | SELECT | INSERT | UPDATE | DELETE | Maximum | Accepted MIME types | Ownership |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `avatars` | Yes | `{user_id}/{timestamp}.{ext}` | Public object reads; public profile avatar URLs are intentional | Authenticated caller's own first path segment | Same owner path | Same owner path | 5 MiB | `image/jpeg`, `image/png`, `image/webp` | User ID from `auth.uid()`; public display image |
| `post_media` | No | `{user_id}/{timestamp}.{ext}` | Authenticated caller may read own uploads, or objects referenced by a post visible under the `posts` RLS policy | Caller-owned path and canonical `posts.create` permission | Caller-owned path and `posts.create` | Caller-owned path | 15 MiB | JPEG, PNG, WebP, GIF | Uploader path; referenced post visibility follows its RLS scope and deletion/moderation state |
| `chat_media` | No | `{conversation_id}/{user_id}/{filename}` | Current conversation members only | Current member and caller-owned uploader segment | Same uploader and current membership | Same uploader and current membership | 25 MiB | JPEG, PNG, WebP, MPEG audio, Ogg audio, WebM audio, MP4, WebM video | Conversation membership plus uploader ID bound to `auth.uid()` |
| `course_files` | No | `{course_id}/{uploader_id}/{shared_file_id}/{filename}` | Requires a matching, active `shared_files` row whose course, uploader, file ID, and path all match; public rows are readable only by actual course participants | `materials.upload` plus teaching assignment or scoped course management; uploader path must equal `auth.uid()` and file ID must be a UUID | Same uploader and course upload authorization; metadata cannot change its course, uploader, or ID | Same uploader, `materials.upload`, and current course scope | 50 MiB | PDF, DOC, DOCX, PPTX, XLSX, plain text, JPEG, PNG, WebP, MP4, WebM | Shared-file metadata is bound to the course, uploader, and row ID; `is_public` means visible to authorized course participants, not internet-public |

Bucket size and MIME restrictions are configured in `storage.buckets` by the
migration. MIME types are upload metadata checks, not content-signature or
malware scanning. The Supabase Storage API must be used for object deletion;
Supabase blocks direct SQL deletes to avoid orphaning object bytes.

## Flutter call-site audit

- `avatars`: `profile_editing_sections.dart` writes under the authenticated
  user's folder and stores the public URL through the owner-bound
  `update_my_profile` RPC.
- `post_media`: `post_repository.dart` now derives the path owner from the
  authenticated Supabase session, stores the object path in `posts.media_urls`,
  and requests a one-hour signed URL only after the post query has passed RLS.
  Legacy public post-media URLs are recognized and converted to paths when
  returned by the repository, and the Storage read policy matches the path
  suffix in those legacy rows so they remain visible only to readers who can
  select the corresponding post.
- Shared files: the canonical object path is
  `{course_id}/{uploader_id}/{shared_file_id}/{filename}` relative to the
  private `course_files` bucket. Database INSERT/UPDATE policies and Storage
  SELECT policies validate the same course/uploader/file-ID binding. A
  metadata row cannot grant access to an object until the matching Storage
  object exists.
  The current professor
  dialog supplies a placeholder local path and does not upload file bytes or
  select a course. `course_files` is provisioned for the explicit course/uploader
  path contract. The placeholder upload UI is not a working file upload and
  must not be treated as one.
- Chat: `messages.media_url` exists in the database contract, but no Flutter
  message-media uploader or `chat_media` bucket call exists yet. The bucket is
  provisioned with membership-bound policies for the later chat media workflow.
- The generic `BaseRepository.uploadFile` and `getSignedUrl` wrappers contain
  no current call sites. Signed URL generation remains subject to the same
  Storage SELECT policy as object reads.

## Privileged client operation audit

- No Flutter service-role, database password, provider secret, or private key
  usage was found.
- Canonical role changes are not exposed as direct Flutter table writes. The
  existing `assign_student_advisor` security-definer RPC remains the narrowly
  scoped server-side workflow from Phase 3; it checks `auth.uid()`, canonical
  permission, student/advisor role, and college scope.
- `EnrollmentRepository.markInvoicePaid` and its notifier, which attempted to
  write `status = paid` and a client timestamp, were removed. Phase 4 already
  grants invoice SELECT only and denies client invoice/payment transaction
  writes.
- There is no payment provider configured or selected. Payment initiation,
  provider webhook verification, idempotent settlement, refunds, and audit
  records remain server-side work and have not been simulated with a fake
  provider. No Edge Function was added because the repository has no provider
  operation to implement yet; the existing verified advisor assignment remains
  a database RPC.

## Validation and limits

`supabase/tests/phase5_storage_authorization.test.sql` checks bucket visibility,
size and MIME configuration; allowed and denied avatar/post uploads; public
avatar reads and anonymous denial for private post media; signed-media source
visibility; private conversation and course file access; cross-user and
cross-college denials; owner update behavior; malformed path denial; and the
installed object deletion policies. Delete policies are inspected through
`pg_policies`, since the local Storage trigger intentionally rejects direct SQL
DELETE statements; object removal itself must be exercised through the Storage
API.

The current shared-file dialog is placeholder behavior, and there is no chat
media client flow. Edge Function authorization has no endpoint to test until a
real privileged/provider workflow is selected. Course file upload and download
still require the client flow to create matching `shared_files` metadata with
the documented path.
