/*
    Clean up database
*/
delete from web.sessions_speakers
delete from web.speakers
delete from web.sessions
go

/*
    Add sample speakers
*/
insert into web.speakers 
    (id, full_name, email) 
values
    (1, 'John Doe', 'johndoe@acme.com'),
    (2, 'Jane Dean', 'janedean@acme.com')
;

/*
    Add sample sessions
*/
insert into web.sessions 
    (id, title, [owner], abstract, tags, last_updated)
values
    (1001, 'From databases to API: an efficient solution both on-premises and in Azure', 'johndoe@acme.com', 'Data API builder turns Azure Databases into REST a GraphQL API so that you can have the backend for your next modern application done in just a few minutes instead of days. With full support to authentication and authorization, integrated with Static Web Apps and easily scalable up and out – using API Management – Data API builder is something you really want to look at. Available both on Azure and on-premises, and Open Source, this is very likely to become your favorite tool. Come and learn everything about it!', '["api", "rest", "graphql", "open-api"]', sysdatetime()),
    (1002, 'Some cool title here', 'janedean@acme.com', 'Some cool abstract about cool web technology.', '["web"]', sysdatetime())
;

/*
    Associate speakers to sessions
*/
insert into web.sessions_speakers 
    (session_id, speaker_id)    
values
    (1001, 1),
    (1002, 2)
go

/*
    View the data
*/
select * from web.sessions;

select * from web.speakers;

select * from web.sessions_speakers;

select
    title,
    full_name
from
    web.sessions s 
inner join
    web.sessions_speakers ss on s.id = ss.session_id 
inner join
    web.speakers sp on ss.speaker_id = sp.id
where
    s.title like 'API';

select
    title,
    full_name
from
    web.sessions s 
inner join
    web.sessions_speakers ss on s.id = ss.session_id
inner join
    web.speakers sp on ss.speaker_id = sp.id
where
    sp.full_name = 'John Doe'

