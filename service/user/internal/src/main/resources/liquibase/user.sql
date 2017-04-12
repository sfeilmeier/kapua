-- *******************************************************************************
-- Copyright (c) 2011, 2016 Eurotech and/or its affiliates and others
--
-- All rights reserved. This program and the accompanying materials
-- are made available under the terms of the Eclipse Public License v1.0
-- which accompanies this distribution, and is available at
-- http://www.eclipse.org/legal/epl-v10.html
--
-- Contributors:
--     Eurotech - initial API and implementation
-- *******************************************************************************

--liquibase formatted sql

--changeset user:1

CREATE TABLE usr_user (
  scope_id             		BIGINT(21) 	  UNSIGNED NOT NULL,
  id                     	BIGINT(21) 	  UNSIGNED NOT NULL,
  name               	    VARCHAR(255)  NOT NULL,
  created_on             	TIMESTAMP(3)  NOT NULL,
  created_by             	BIGINT(21)    UNSIGNED NOT NULL,
  modified_on            	TIMESTAMP(3),
  modified_by            	BIGINT(21)    UNSIGNED,
  status                 	VARCHAR(64)   NOT NULL DEFAULT 'ENABLED',
  display_name           	VARCHAR(255),
  email                  	VARCHAR(255),
  phone_number           	VARCHAR(64),
  user_type					VARCHAR(64)   NOT NULL DEFAULT 'INTERNAL',
  external_id				VARCHAR(255),
  optlock               	INT UNSIGNED,
  attributes             	TEXT,  
  properties             	TEXT,  

  PRIMARY KEY (id),
  CONSTRAINT usr_uc_name UNIQUE (name)
) DEFAULT CHARSET=utf8;

CREATE INDEX idx_user_scope_id ON usr_user (scope_id);

--changeset user:2

INSERT INTO `usr_user` (`scope_id`, `id`, `name`, `created_on`, `created_by`, `modified_on`, `modified_by`, `status`, `display_name`, `email`, `phone_number`, `user_type`, `external_id`, `optlock`, `attributes`, `properties`)
		VALUES (1, 1, 'kapua-sys',    CURRENT_TIMESTAMP(), 1, CURRENT_TIMESTAMP(), 1, 'ENABLED', 'Kapua Sysadmin', 'kapua-sys@eclipse.org',    '+1 555 123 4567', 'INTERNAL', NULL, 0, NULL, NULL),
		       (1, 2, 'kapua-broker', CURRENT_TIMESTAMP(), 1, CURRENT_TIMESTAMP(), 1, 'ENABLED', 'Kapua Broker',   'kapua-broker@eclipse.org', '+1 555 123 4567', 'INTERNAL', NULL, 0, NULL, NULL);

--changeset user:3

-- WARNING: to be kept in sync with kapua/commons/src/main/resources/liquibase/configuration.sql
CREATE TABLE IF NOT EXISTS sys_configuration (
  scope_id          		 BIGINT(21) 	  UNSIGNED,
  id                         BIGINT(21) 	  UNSIGNED NOT NULL,
  pid						 VARCHAR(255) 	  NOT NULL,
  configurations			 TEXT,
  created_on                 TIMESTAMP(3) 	  DEFAULT 0,
  created_by                 BIGINT(21) 	  UNSIGNED NOT NULL,
  modified_on                TIMESTAMP(3) 	  NOT NULL,
  modified_by                BIGINT(21) 	  UNSIGNED NOT NULL,
  optlock                    INT UNSIGNED,
  attributes				 TEXT,
  properties                 TEXT,
  PRIMARY KEY  (id),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE INDEX IF NOT EXISTS idx_configurationScopeId ON sys_configuration (scope_id);

INSERT INTO sys_configuration (
  SCOPE_ID,
  ID,
  PID,
  CONFIGURATIONS,
  CREATED_ON,
  CREATED_BY,
  MODIFIED_ON,
  MODIFIED_BY,
  OPTLOCK,
  ATTRIBUTES,
  PROPERTIES)
VALUES (1,
        2,
        'org.eclipse.kapua.service.account.UserService',
        CONCAT('#', CURRENT_TIMESTAMP(), CHAR(13), CHAR(10),
        'maxNumberChildEntities=0', CHAR(13), CHAR(10),
        'infiniteChildEntities=true'),
  CURRENT_TIMESTAMP(),
  1,
  CURRENT_TIMESTAMP(),
  1,
  0,
  null,
  null);