-- part 1: can be applied on archive running archive 5.16
alter table queue_msg add batch_id varchar(255);
alter table retrieve_task
    add device_name varchar(255),
    add queue_name varchar(255),
    add batch_id varchar(255);
alter table retrieve_task alter column queue_msg_fk drop not null;
alter table stgcmt_result alter column exporter_id drop not null;
alter table series add metadata_update_failures int4;
alter table metadata add created_time timestamp;

update queue_msg set batch_id = batchID;
update retrieve_task
    set device_name = queue_msg.device_name,
        queue_name  = queue_msg.queue_name,
        batch_id    = queue_msg.batch_id
    from queue_msg
    where queue_msg_fk = queue_msg.pk;
update series set metadata_update_failures = 0;
update metadata
    set created_time = series.updated_time
    from series
    where metadata.pk = metadata_fk;

create index UK_ln9rs61la03lhvgiv8c2wehnr on queue_msg (batch_id);
create index UK_djkqk3dls3xkru1n0c3p5rm3 on retrieve_task (device_name);
create index UK_r866eptnxfw7plhxwtm3vks0e on retrieve_task (queue_name);
create index UK_ahkqwir2di2jm44jlhi22iw3e on retrieve_task (batch_id);
create index UK_6xqpk4cvy49wj41p2qwixro8w on series (metadata_update_failures);
