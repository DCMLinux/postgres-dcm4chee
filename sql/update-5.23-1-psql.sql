-- part 1: can be applied on archive running archive 5.22
alter table person_name
    add alphabetic_name varchar(255),
    add ideographic_name varchar(255),
    add phonetic_name varchar(255);

update person_name
set alphabetic_name = concat(family_name, '^', given_name, '^', middle_name, '^', name_prefix, '^', name_suffix, '^'),
    ideographic_name = concat(i_family_name, '^', i_given_name, '^', i_middle_name, '^', i_name_prefix, '^', i_name_suffix, '^'),
    phonetic_name = concat(p_family_name, '^', p_given_name, '^', p_middle_name, '^', p_name_prefix, '^', p_name_suffix, '^');

create index UK_gs2yshbwu0gkd33yxyv13keoh on person_name (alphabetic_name);
create index UK_ala4l4egord8i2tjvjidoqd1s on person_name (ideographic_name);
create index UK_9nr8ddkp8enufvbn72esyw3n1 on person_name (phonetic_name);

create index alphabetic_name_upper_idx on person_name (upper(alphabetic_name));

alter table issuer drop constraint UK_gknfxd1vh283cmbg8ymia9ms8;
create index UK_gknfxd1vh283cmbg8ymia9ms8 on issuer (entity_id);
