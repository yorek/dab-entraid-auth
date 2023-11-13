delete from web.sessions_speakers
delete from web.speakers
delete from web.sessions
go

insert into web.speakers 
    (id, full_name, email) 
values
    (1, 'Davide Mauri', 'damauri@microsoft.com'),
    (2, 'Mete Atamel', 'dontknow@acme.com')
;

insert into web.sessions 
    (id, title, [owner], abstract, tags, last_updated)
values
    (1001, 'Data API builder: creare CRUD API non e'' mai stato cosi semplice!', 'damauri@microsoft.com', 'Creare delle API CRUD per accedere ai dati, da integrare in soluzioni fullstack o jamstack, o in architetture basate su microservizi, e'' una sfida comune per uno sviluppatore. Ma anche una fonte di noia e difficoltà. Non si tratta solo di restituire una lista di dati. Spesso e'' necessario paginare il risultato, di selezionare quali proprietà includere e di filtrare i dati inutili, per ottimizzare la quantità di dati restituita, Per non parlare di autenticazione e autorizzazione e di supportare sia REST che GraphQL. Bene: da oggi potrai fare tutto questo in pochi minuti. Non perdere questa sessione!', '["api", "rest", "graphql", "open-api"]', sysdatetime()),
    (1002, 'WebAssembly beyond the browser', 'dontknow@acme.com', 'WebAssembly (Wasm) allows you to compile native code and run it in a secure and performant way in the browser. The WASI project started enabling Wasm to run outside the web browser in environments such as edge computing and cloud microservices. Docker has also recently announced support for Wasm, allowing it to be used as a lightweight alternative to Linux containers. Whether Wasm will replace containers remains to be seen but it''s definitely worth learning more about it. In this talk, I''ll introduce Wasm, the terminology and landscape around it, and its current state as a server side technology.', '["web"]', sysdatetime())
;

insert into web.sessions_speakers 
    (session_id, speaker_id)    
values
    (1001, 1),
    (1002, 2)
go
---

select * from web.sessions

select * from web.speakers

select * from web.sessions_speakers

--- 

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
    s.title like 'CRUD'

---

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
    sp.full_name = 'Davide Mauri'

