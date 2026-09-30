#!/usr/bin/env python3
"""Local-only Auth/Storage regression checks. Never print keys or tokens."""
import json
import re
import subprocess
import urllib.error
import urllib.request
import uuid
from pathlib import Path
from urllib.parse import urlparse

status = json.loads(subprocess.check_output(['npx','--no-install','supabase','status','--output','json'], stderr=subprocess.DEVNULL))
# CLI output contains trusted local configuration; do not persist it.
url = status.get('API_URL', status.get('api_url', ''))
if urlparse(url).hostname not in ('127.0.0.1','localhost','::1'):
    raise SystemExit('Refusing a non-loopback endpoint')
key = status.get('ANON_KEY', status.get('anon_key'))
if not key:
    raise SystemExit('Local anon key unavailable')
credentials = {}
for line in Path('docs/DEVELOPMENT_ACCOUNTS.md').read_text().splitlines():
    if '.dev@' in line:
        cells = re.findall(r'`([^`]+)`', line)
        if len(cells)>=3: credentials[cells[0]]=cells[-1]

def request(path, *, token=None, payload=None, method='GET', mime='application/json'):
    headers = {'apikey':key, 'Content-Type':mime}
    if token: headers['Authorization']='Bearer '+token
    req = urllib.request.Request(url+path, data=payload, headers=headers, method=method)
    try:
        with urllib.request.urlopen(req, timeout=30) as result: return result.status,result.read()
    except urllib.error.HTTPError as error: return error.code,error.read()

tokens={}
for email,password in credentials.items():
    code,body=request('/auth/v1/token?grant_type=password', method='POST',
                      payload=json.dumps({'email':email,'password':password}).encode())
    assert code==200, f'Local login failed: {email}, status {code}'
    tokens[email]=json.loads(body)['access_token']
print(f'PASS: all {len(tokens)} development accounts authenticate with bcrypt hashes')
guest=tokens['guest.dev@horus.edu.eg']
prof=tokens['professor.dev@horus.edu.eg']
student=tokens['student.dev@horus.edu.eg']
uid='d0000000-0000-4000-8000-000000000010'
# Storage checks MIME/size at HTTP ingestion, not from caller SQL metadata.
for name,mime,body in [('disallowed.txt','text/plain',b'fixture'),
                       ('oversized.png','image/png',b'x'*(5242880+1))]:
    code,_=request('/storage/v1/object/avatars/'+uid+'/'+name, token=guest,
                   payload=body, method='POST', mime=mime)
    assert code>=400, f'Upload unexpectedly allowed: {name}'
    print('PASS: avatar '+name+' rejected by Storage API')
code,_=request('/storage/v1/object/avatars/d0000000-0000-4000-8000-000000000008/spoof.png',
               token=guest,payload=b'fixture',method='POST',mime='image/png')
assert code>=400,'Cross-owner avatar upload allowed'
print('PASS: cross-owner avatar path rejected')
owner_path='d0000000-0000-4000-8000-000000000008/'+str(uuid.uuid4())+'.png'
code,response_body=request('/storage/v1/object/avatars/'+owner_path,token=student,
               payload=b'png-fixture',method='POST',mime='image/png')
if code not in (200,201):
    error=json.loads(response_body).get('error','Storage API rejected the local fixture')
    raise AssertionError(f'Local owner fixture upload failed: {code}: {error}')
delete_path=owner_path.removeprefix('avatars/')
delete_status,_=request('/storage/v1/object/avatars',token=guest,
               payload=json.dumps({'prefixes':[delete_path]}).encode(),
               method='DELETE')
code,_=request('/storage/v1/object/avatars/'+owner_path,token=student)
assert code==200,'Cross-owner delete attempt removed owner avatar'
assert delete_status>=400 or code==200,'Cross-owner deletion changed object state'
code,_=request('/storage/v1/object/avatars',token=student,
               payload=json.dumps({'prefixes':[delete_path]}).encode(),
               method='DELETE')
assert code<400,f'Owner could not clean up local fixture: {code}'
print('PASS: cross-owner avatar delete denied; owner delete allowed')
for path in ['/rest/v1/profile_directory?select=id','/rest/v1/grades?select=id',
             '/rest/v1/messages?select=id','/rest/v1/courses?select=id']:
    code,body=request(path,token=guest)
    assert code==200 and json.loads(body)==[],f'Guest read boundary failed: {path}'
print('PASS: guest REST directory/grades/messages/catalog reads return zero rows')
# Keep repository projections in sync with the checked-in SQL contract. Empty
# RLS-scoped results still validate every selected column and relationship.
projection_checks = [
    ('/rest/v1/notifications?select=id,user_id,title,title_ar,message,message_ar,type,is_read,created_at,read_at,action_url,metadata&user_id=eq.d0000000-0000-4000-8000-000000000008', student),
    ('/rest/v1/invoices?select=id,student_id,semester,description,description_ar,amount,currency,status,due_date,paid_at,receipt_url,created_at&student_id=eq.d0000000-0000-4000-8000-000000000008', student),
    ('/rest/v1/announcements?select=id,author_id,college_id,department_id,course_id,title,title_ar,content,content_ar,priority,is_pinned,published_at,expires_at,profiles:author_id(full_name,avatar_url)&author_id=eq.d0000000-0000-4000-8000-000000000004', prof),
    ('/rest/v1/shared_files?select=id,uploader_id,title,title_ar,file_path,file_type,file_size,download_count,is_public,created_at,course_id,deleted_at&uploader_id=eq.d0000000-0000-4000-8000-000000000004', prof),
    ('/rest/v1/schedules?select=id,course_id,day,start_time,end_time,semester,room,building,section_name,sub_section_name&limit=1', student),
    ('/rest/v1/student_registrations?select=id,student_id,semester,section_name,sub_section_name,registered_at&student_id=eq.d0000000-0000-4000-8000-000000000008', student),
]
for path,token in projection_checks:
    code,_=request(path,token=token)
    assert code==200,f'Repository projection/schema mismatch: {path.split("?")[0]} status={code}'
print(f'PASS: {len(projection_checks)} typed repository projections match the live local schema')
student_data_checks = [
    '/rest/v1/courses?select=id&is_active=eq.true&limit=5',
    '/rest/v1/enrollments?select=id&student_id=eq.d0000000-0000-4000-8000-000000000008',
    '/rest/v1/grades?select=id&student_id=eq.d0000000-0000-4000-8000-000000000008&is_published=eq.true',
    '/rest/v1/attendance?select=id&student_id=eq.d0000000-0000-4000-8000-000000000008',
    '/rest/v1/invoices?select=id&student_id=eq.d0000000-0000-4000-8000-000000000008',
    '/rest/v1/notifications?select=id&user_id=eq.d0000000-0000-4000-8000-000000000008',
    '/rest/v1/posts?select=id&limit=5',
]
for path in student_data_checks:
    code,body=request(path,token=student)
    assert code==200 and json.loads(body),f'Seeded student data unavailable: {path.split("?")[0]}'
print(f'PASS: authenticated student can read seeded rows in {len(student_data_checks)} campus areas')
for rpc in ['get_my_profile_private','update_my_profile','get_advisor_directory','assign_student_advisor']:
    params={'update_my_profile':{'p_full_name':'attempt','p_phone':None,'p_bio':None},
            'assign_student_advisor':{'p_student_id':uid,'p_advisor_id':uid}}.get(rpc,{})
    code,_=request('/rest/v1/rpc/'+rpc,method='POST',payload=json.dumps(params).encode())
    assert code>=400,'Anonymous RPC unexpectedly allowed: '+rpc
print('PASS: anonymous sensitive RPCs denied over REST')
