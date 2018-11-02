create table user(
	uid int unsigned not null auto_increment comment '用户ID',
	real_name varchar(20) not null comment '真实姓名',
	username varchar(20) not null comment '用户名',
	password varchar(32) not null comment '密码',
	status tinyint unsigned not null default 1 comment '状态： 1-启用；0-禁用',
	createAt int unsigned not null default 0 comment '创建时间',
	updateAt int unsigned not null default 0 comment '修改时间',
	note text not null default '' comment '备注',
	p_uid int unsigned not null default 0 comment '所属用户ID',
	PRIMARY KEY (`uid`),
	unique key unique_username_password (`username`,`password`)
)engine=innodb default charset=utf8 comment '用户表';



insert ignore into user(username, password, real_name,note) values ('sky', '62ef34f4e7b271b4ccdb5cbeb1546fd5', '管理员', '超级管理员');



CREATE TABLE permission (
   permission_id int unsigned not null auto_increment comment '权限ID',
   url varchar(256) not NULL COMMENT 'url地址',
   name varchar(64) not NULL DEFAULT '' COMMENT 'url描述',
   parent_id int unsigned not null DEFAULT 0 comment '父级ID',
   type tinyint unsigned not null default 1 comment '类型： 1-url；0-ajax; 2-no-show',
   sort tinyint unsigned not null default 0 comment '排序',
   is_show tinyint unsigned not null default 1 comment '显示状态',
   PRIMARY KEY (`permission_id`)
) engine=innodb default charset=utf8 comment '权限表';



CREATE TABLE role (
  role_id int unsigned not null auto_increment comment '角色ID',
  name varchar(32) DEFAULT '' COMMENT '角色名称',
  type varchar(32) DEFAULT '' COMMENT '角色类型',
  PRIMARY KEY (`role_id`)
) engine=innodb default charset=utf8 comment '角色表';



CREATE TABLE role_permission (
  role_id int unsigned not null COMMENT '角色ID',
  permission_id int unsigned not null COMMENT '权限ID'
) engine=innodb default charset=utf8 comment '角色权限关联表';



CREATE TABLE user_role (
  uid int unsigned not null COMMENT '用户ID',
  role_id int unsigned not null COMMENT '角色ID'
) engine=innodb default charset=utf8 comment '用户角色关联表';



CREATE TABLE project (
  project_id int unsigned not null auto_increment COMMENT '项目ID',
  name varchar(32) not null  DEFAULT '' COMMENT '项目名称',
  uid int unsigned not null COMMENT '负责人',
  type tinyint unsigned not null default 1 comment '类型',
  c_type tinyint unsigned not null default 1 comment '子类型',
  status tinyint unsigned not null default 1 comment '状态',
  note text not null default '' comment '备注',
	createAt int unsigned not null default 0 comment '创建时间',
	updateAt int unsigned not null default 0 comment '修改时间',
	PRIMARY KEY (`project_id`)
) engine=innodb default charset=utf8 comment '项目表';



CREATE TABLE contract (
  contract_id varchar(32) not null  COMMENT '合同ID',
  project_id int unsigned not null  COMMENT '项目ID',
  pr varchar(32) not null DEFAULT ''  COMMENT 'pr号',
  po varchar(32) not null DEFAULT ''  COMMENT 'po号',
  name varchar(32) not null DEFAULT '' COMMENT '合同名称',
  type tinyint unsigned not null default 1 comment '类型',
  start_time int unsigned not null default 0 comment '开始时间',
	end_time int unsigned not null default 0 comment '结束时间',
	money DOUBLE not null comment '合同金额',
	real_money DOUBLE not null comment '真实金额',
  status tinyint unsigned not null default 1 comment '状态',
  conform_time int unsigned not null default 0 comment '签订时间',
  note text not null default '' comment '备注',
  attachs text not null default '' comment '附件',
	createAt int unsigned not null default 0 comment '创建时间',
	updateAt int unsigned not null default 0 comment '修改时间',
	supplier_id int unsigned not null DEFAULT 0 COMMENT '供应商ID',
	pid varchar(32) not null DEFAULT '' COMMENT '父ID',
	PRIMARY KEY (`contract_id`)
) engine=innodb default charset=utf8 comment '合同表';



CREATE TABLE invoice (
  invoice_id int unsigned not null auto_increment COMMENT  '发票ID',
  contract_id varchar(32) not null  COMMENT '合同ID',
  type tinyint unsigned not null default 1 comment '类型',
  status tinyint unsigned not null default 1 comment '状态',
  money DOUBLE not null comment '发票金额',
  tax DOUBLE not null comment '税点',
  offer_time int unsigned not null default 0 comment '开具时间',
  note text not null default '' comment '备注',
  attachs text not null default '' comment '附件',
	createAt int unsigned not null default 0 comment '创建时间',
	updateAt int unsigned not null default 0 comment '修改时间',
	PRIMARY KEY (`invoice_id`)
) engine=innodb default charset=utf8 comment '发票表';



CREATE TABLE payment (
  payment_id int unsigned not null auto_increment COMMENT '付款ID',
  invoice_id int unsigned not null  COMMENT '发票ID',
  type tinyint unsigned not null default 1 comment '类型',
  status tinyint unsigned not null default 0 comment '状态',
  money DOUBLE not null comment '金额',
  handle_time int unsigned not null default 0 comment '付款时间',
  note text not null default '' comment '备注',
	createAt int unsigned not null default 0 comment '创建时间',
	updateAt int unsigned not null default 0 comment '修改时间',
	PRIMARY KEY (`payment_id`)
) engine=innodb default charset=utf8 comment '支付记录表';


CREATE TABLE supplier (
  supplier_id int unsigned not null auto_increment COMMENT '供应商ID',
  name varchar(32) not null DEFAULT '' COMMENT '名称',
  type tinyint unsigned not null default 1 comment '类型',
  c_type tinyint unsigned not null default 1 comment '子类型',
  govcode  varchar(32) not null DEFAULT '' COMMENT '组织机构代码',
  mobile  varchar(32) not null DEFAULT '' COMMENT '联系方式',
  bank varchar(32) not null DEFAULT '' COMMENT '开户行',
  bank_code varchar(32) not null DEFAULT '' COMMENT '银行卡号',
  note text not null default '' comment '备注',
  attachs text not null default '' comment '附件',
	createAt int unsigned not null default 0 comment '创建时间',
	updateAt int unsigned not null default 0 comment '修改时间',
	PRIMARY KEY (`supplier_id`)
) engine=innodb default charset=utf8 comment '供应商表';


CREATE TABLE dict (
  dict_id int unsigned not null auto_increment COMMENT '字典ID',
  pid int unsigned not null DEFAULT 0 COMMENT '父ID',
  code tinyint unsigned not null default 0 comment '代码',
  name varchar(32) not null DEFAULT '' COMMENT '名称',
  title varchar(32) not null DEFAULT '' COMMENT '标示',
  sort tinyint unsigned not null default 0 comment '排序',
  type tinyint unsigned not null default 0 comment '0父级  1子级',
  status tinyint unsigned not null default 1 comment '状态',
	createAt int unsigned not null default 0 comment '创建时间',
	updateAt int unsigned not null default 0 comment '修改时间',
	PRIMARY KEY (`dict_id`)
) engine=innodb default charset=utf8 comment '字典表';


CREATE TABLE `payment_info` (
  `info_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '付款方式Id',
  `contract_id` varchar(32) NOT NULL COMMENT '合同Id',
  `info_money` double NOT NULL COMMENT '付款金额',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付款信息表';

