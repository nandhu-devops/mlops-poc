-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: mlpipeline
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Artifact`
--

DROP TABLE IF EXISTS `Artifact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Artifact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `uri` text,
  `state` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `create_time_since_epoch` bigint(20) NOT NULL DEFAULT '0',
  `last_update_time_since_epoch` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UniqueArtifactTypeName` (`type_id`,`name`),
  KEY `idx_artifact_uri` (`uri`(255)),
  KEY `idx_artifact_create_time_since_epoch` (`create_time_since_epoch`),
  KEY `idx_artifact_last_update_time_since_epoch` (`last_update_time_since_epoch`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Artifact`
--

LOCK TABLES `Artifact` WRITE;
/*!40000 ALTER TABLE `Artifact` DISABLE KEYS */;
/*!40000 ALTER TABLE `Artifact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ArtifactProperty`
--

DROP TABLE IF EXISTS `ArtifactProperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArtifactProperty` (
  `artifact_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_custom_property` tinyint(1) NOT NULL,
  `int_value` int(11) DEFAULT NULL,
  `double_value` double DEFAULT NULL,
  `string_value` mediumtext,
  `byte_value` mediumblob,
  PRIMARY KEY (`artifact_id`,`name`,`is_custom_property`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ArtifactProperty`
--

LOCK TABLES `ArtifactProperty` WRITE;
/*!40000 ALTER TABLE `ArtifactProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `ArtifactProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Association`
--

DROP TABLE IF EXISTS `Association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Association` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `context_id` int(11) NOT NULL,
  `execution_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `context_id` (`context_id`,`execution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Association`
--

LOCK TABLES `Association` WRITE;
/*!40000 ALTER TABLE `Association` DISABLE KEYS */;
/*!40000 ALTER TABLE `Association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attribution`
--

DROP TABLE IF EXISTS `Attribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attribution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `context_id` int(11) NOT NULL,
  `artifact_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `context_id` (`context_id`,`artifact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attribution`
--

LOCK TABLES `Attribution` WRITE;
/*!40000 ALTER TABLE `Attribution` DISABLE KEYS */;
/*!40000 ALTER TABLE `Attribution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Context`
--

DROP TABLE IF EXISTS `Context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Context` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `create_time_since_epoch` bigint(20) NOT NULL DEFAULT '0',
  `last_update_time_since_epoch` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_id` (`type_id`,`name`),
  KEY `idx_context_create_time_since_epoch` (`create_time_since_epoch`),
  KEY `idx_context_last_update_time_since_epoch` (`last_update_time_since_epoch`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Context`
--

LOCK TABLES `Context` WRITE;
/*!40000 ALTER TABLE `Context` DISABLE KEYS */;
/*!40000 ALTER TABLE `Context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContextProperty`
--

DROP TABLE IF EXISTS `ContextProperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContextProperty` (
  `context_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_custom_property` tinyint(1) NOT NULL,
  `int_value` int(11) DEFAULT NULL,
  `double_value` double DEFAULT NULL,
  `string_value` mediumtext,
  `byte_value` mediumblob,
  PRIMARY KEY (`context_id`,`name`,`is_custom_property`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContextProperty`
--

LOCK TABLES `ContextProperty` WRITE;
/*!40000 ALTER TABLE `ContextProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContextProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Event`
--

DROP TABLE IF EXISTS `Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `artifact_id` int(11) NOT NULL,
  `execution_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `milliseconds_since_epoch` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_event_artifact_id` (`artifact_id`),
  KEY `idx_event_execution_id` (`execution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event`
--

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventPath`
--

DROP TABLE IF EXISTS `EventPath`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventPath` (
  `event_id` int(11) NOT NULL,
  `is_index_step` tinyint(1) NOT NULL,
  `step_index` int(11) DEFAULT NULL,
  `step_key` text,
  KEY `idx_eventpath_event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventPath`
--

LOCK TABLES `EventPath` WRITE;
/*!40000 ALTER TABLE `EventPath` DISABLE KEYS */;
/*!40000 ALTER TABLE `EventPath` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Execution`
--

DROP TABLE IF EXISTS `Execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Execution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `last_known_state` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `create_time_since_epoch` bigint(20) NOT NULL DEFAULT '0',
  `last_update_time_since_epoch` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UniqueExecutionTypeName` (`type_id`,`name`),
  KEY `idx_execution_create_time_since_epoch` (`create_time_since_epoch`),
  KEY `idx_execution_last_update_time_since_epoch` (`last_update_time_since_epoch`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Execution`
--

LOCK TABLES `Execution` WRITE;
/*!40000 ALTER TABLE `Execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `Execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExecutionProperty`
--

DROP TABLE IF EXISTS `ExecutionProperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExecutionProperty` (
  `execution_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_custom_property` tinyint(1) NOT NULL,
  `int_value` int(11) DEFAULT NULL,
  `double_value` double DEFAULT NULL,
  `string_value` mediumtext,
  `byte_value` mediumblob,
  PRIMARY KEY (`execution_id`,`name`,`is_custom_property`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExecutionProperty`
--

LOCK TABLES `ExecutionProperty` WRITE;
/*!40000 ALTER TABLE `ExecutionProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExecutionProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MLMDEnv`
--

DROP TABLE IF EXISTS `MLMDEnv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MLMDEnv` (
  `schema_version` int(11) NOT NULL,
  PRIMARY KEY (`schema_version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MLMDEnv`
--

LOCK TABLES `MLMDEnv` WRITE;
/*!40000 ALTER TABLE `MLMDEnv` DISABLE KEYS */;
INSERT INTO `MLMDEnv` VALUES (7);
/*!40000 ALTER TABLE `MLMDEnv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParentContext`
--

DROP TABLE IF EXISTS `ParentContext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ParentContext` (
  `context_id` int(11) NOT NULL,
  `parent_context_id` int(11) NOT NULL,
  PRIMARY KEY (`context_id`,`parent_context_id`),
  KEY `idx_parentcontext_parent_context_id` (`parent_context_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ParentContext`
--

LOCK TABLES `ParentContext` WRITE;
/*!40000 ALTER TABLE `ParentContext` DISABLE KEYS */;
/*!40000 ALTER TABLE `ParentContext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParentType`
--

DROP TABLE IF EXISTS `ParentType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ParentType` (
  `type_id` int(11) NOT NULL,
  `parent_type_id` int(11) NOT NULL,
  PRIMARY KEY (`type_id`,`parent_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ParentType`
--

LOCK TABLES `ParentType` WRITE;
/*!40000 ALTER TABLE `ParentType` DISABLE KEYS */;
/*!40000 ALTER TABLE `ParentType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Type`
--

DROP TABLE IF EXISTS `Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `type_kind` tinyint(1) NOT NULL,
  `description` text,
  `input_type` text,
  `output_type` text,
  PRIMARY KEY (`id`),
  KEY `idx_type_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Type`
--

LOCK TABLES `Type` WRITE;
/*!40000 ALTER TABLE `Type` DISABLE KEYS */;
INSERT INTO `Type` VALUES (1,'mlmd.Dataset',NULL,1,NULL,NULL,NULL),(2,'mlmd.Model',NULL,1,NULL,NULL,NULL),(3,'mlmd.Metrics',NULL,1,NULL,NULL,NULL),(4,'mlmd.Statistics',NULL,1,NULL,NULL,NULL),(5,'mlmd.Train',NULL,0,NULL,NULL,NULL),(6,'mlmd.Transform',NULL,0,NULL,NULL,NULL),(7,'mlmd.Process',NULL,0,NULL,NULL,NULL),(8,'mlmd.Evaluate',NULL,0,NULL,NULL,NULL),(9,'mlmd.Deploy',NULL,0,NULL,NULL,NULL),(10,'DummyExecutionType',NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TypeProperty`
--

DROP TABLE IF EXISTS `TypeProperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TypeProperty` (
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `data_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`type_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TypeProperty`
--

LOCK TABLES `TypeProperty` WRITE;
/*!40000 ALTER TABLE `TypeProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `TypeProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_statuses`
--

DROP TABLE IF EXISTS `db_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_statuses` (
  `HaveSamplesLoaded` tinyint(1) NOT NULL,
  PRIMARY KEY (`HaveSamplesLoaded`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_statuses`
--

LOCK TABLES `db_statuses` WRITE;
/*!40000 ALTER TABLE `db_statuses` DISABLE KEYS */;
INSERT INTO `db_statuses` VALUES (1);
/*!40000 ALTER TABLE `db_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_experiments`
--

DROP TABLE IF EXISTS `default_experiments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_experiments` (
  `DefaultExperimentId` varchar(255) NOT NULL,
  PRIMARY KEY (`DefaultExperimentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_experiments`
--

LOCK TABLES `default_experiments` WRITE;
/*!40000 ALTER TABLE `default_experiments` DISABLE KEYS */;
INSERT INTO `default_experiments` VALUES ('4cff905d-9ecc-48e3-9599-e4454b88599c');
/*!40000 ALTER TABLE `default_experiments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiments`
--

DROP TABLE IF EXISTS `experiments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiments` (
  `UUID` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `CreatedAtInSec` bigint(20) NOT NULL,
  `Namespace` varchar(255) NOT NULL,
  `StorageState` varchar(255) NOT NULL,
  PRIMARY KEY (`UUID`),
  UNIQUE KEY `idx_name_namespace` (`Name`,`Namespace`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiments`
--

LOCK TABLES `experiments` WRITE;
/*!40000 ALTER TABLE `experiments` DISABLE KEYS */;
INSERT INTO `experiments` VALUES ('4cff905d-9ecc-48e3-9599-e4454b88599c','Default','All runs created without specifying an experiment will be grouped here.',1760607064,'','AVAILABLE');
/*!40000 ALTER TABLE `experiments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `UUID` varchar(255) NOT NULL,
  `DisplayName` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Namespace` varchar(255) NOT NULL,
  `ServiceAccount` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `MaxConcurrency` bigint(20) NOT NULL,
  `NoCatchup` tinyint(1) NOT NULL,
  `CreatedAtInSec` bigint(20) NOT NULL,
  `UpdatedAtInSec` bigint(20) DEFAULT '0',
  `Enabled` tinyint(1) NOT NULL,
  `ExperimentUUID` varchar(255) NOT NULL,
  `CronScheduleStartTimeInSec` bigint(20) DEFAULT NULL,
  `CronScheduleEndTimeInSec` bigint(20) DEFAULT NULL,
  `Schedule` varchar(255) DEFAULT NULL,
  `PeriodicScheduleStartTimeInSec` bigint(20) DEFAULT NULL,
  `PeriodicScheduleEndTimeInSec` bigint(20) DEFAULT NULL,
  `IntervalSecond` bigint(20) DEFAULT NULL,
  `PipelineId` varchar(255) NOT NULL,
  `PipelineVersionId` varchar(255) DEFAULT NULL,
  `PipelineName` varchar(255) NOT NULL,
  `PipelineSpecManifest` longtext,
  `WorkflowSpecManifest` longtext NOT NULL,
  `Parameters` longtext,
  `RuntimeParameters` longtext,
  `PipelineRoot` longtext,
  `Conditions` varchar(255) NOT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pipeline_versions`
--

DROP TABLE IF EXISTS `pipeline_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pipeline_versions` (
  `UUID` varchar(255) NOT NULL,
  `CreatedAtInSec` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Parameters` longtext NOT NULL,
  `PipelineId` varchar(255) NOT NULL,
  `Status` varchar(255) NOT NULL,
  `CodeSourceUrl` varchar(255) DEFAULT NULL,
  `Description` longtext NOT NULL,
  `PipelineSpec` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `PipelineSpecURI` longtext NOT NULL,
  PRIMARY KEY (`UUID`),
  UNIQUE KEY `idx_pipelineid_name` (`Name`,`PipelineId`),
  KEY `idx_pipeline_versions_PipelineId` (`PipelineId`),
  KEY `idx_pipeline_versions_CreatedAtInSec` (`CreatedAtInSec`),
  CONSTRAINT `pipeline_versions_PipelineId_pipelines_UUID_foreign` FOREIGN KEY (`PipelineId`) REFERENCES `pipelines` (`UUID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pipeline_versions`
--

LOCK TABLES `pipeline_versions` WRITE;
/*!40000 ALTER TABLE `pipeline_versions` DISABLE KEYS */;
INSERT INTO `pipeline_versions` VALUES ('781b0b56-fd8c-4193-83d1-812fb22176de',1760607063,'[Tutorial] DSL - Control structures','[]','80e9ab7f-ae28-4801-82af-564a078c62c3','READY','','[source code](https://github.com/kubeflow/pipelines/tree/e03e31219387b587b700ba3e31a02df486aa364f/samples/tutorials/DSL%20-%20Control%20structures) Shows how to use conditional execution and exit handlers. This pipeline will randomly fail to demonstrate that the exit handler gets executed even in case of failure.','components:\n  comp-condition-4:\n    dag:\n      tasks:\n        condition-5:\n          componentRef:\n            name: comp-condition-5\n          dependentTasks:\n          - get-random-int-op\n          inputs:\n            parameters:\n              pipelinechannel--flip-coin-op-Output:\n                componentInputParameter: pipelinechannel--flip-coin-op-Output\n              pipelinechannel--get-random-int-op-Output:\n                taskOutputParameter:\n                  outputParameterKey: Output\n                  producerTask: get-random-int-op\n              pipelinechannel--loop-item-param-2:\n                componentInputParameter: pipelinechannel--loop-item-param-2\n          taskInfo:\n            name: condition-5\n          triggerPolicy:\n            condition: int(inputs.parameter_values[\'pipelinechannel--get-random-int-op-Output\'])\n              > 5\n        condition-6:\n          componentRef:\n            name: comp-condition-6\n          dependentTasks:\n          - get-random-int-op\n          inputs:\n            parameters:\n              pipelinechannel--flip-coin-op-Output:\n                componentInputParameter: pipelinechannel--flip-coin-op-Output\n              pipelinechannel--get-random-int-op-Output:\n                taskOutputParameter:\n                  outputParameterKey: Output\n                  producerTask: get-random-int-op\n              pipelinechannel--loop-item-param-2:\n                componentInputParameter: pipelinechannel--loop-item-param-2\n          taskInfo:\n            name: condition-6\n          triggerPolicy:\n            condition: int(inputs.parameter_values[\'pipelinechannel--get-random-int-op-Output\'])\n              <= 5\n        get-random-int-op:\n          cachingOptions:\n            enableCache: true\n          componentRef:\n            name: comp-get-random-int-op\n          inputs:\n            parameters:\n              maximum:\n                runtimeValue:\n                  constant: 9\n              minimum:\n                runtimeValue:\n                  constant: 0\n          taskInfo:\n            name: get-random-int-op\n    inputDefinitions:\n      parameters:\n        pipelinechannel--flip-coin-op-Output:\n          parameterType: STRING\n        pipelinechannel--loop-item-param-2:\n          parameterType: STRING\n  comp-condition-5:\n    dag:\n      tasks:\n        print-op-2:\n          cachingOptions:\n            enableCache: true\n          componentRef:\n            name: comp-print-op-2\n          inputs:\n            parameters:\n              message:\n                runtimeValue:\n                  constant: \'{{$.inputs.parameters[\'\'pipelinechannel--loop-item-param-2\'\']}}\n                    and {{$.inputs.parameters[\'\'pipelinechannel--get-random-int-op-Output\'\']}}\n                    > 5!\'\n              pipelinechannel--get-random-int-op-Output:\n                componentInputParameter: pipelinechannel--get-random-int-op-Output\n              pipelinechannel--loop-item-param-2:\n                componentInputParameter: pipelinechannel--loop-item-param-2\n          taskInfo:\n            name: print-op-2\n    inputDefinitions:\n      parameters:\n        pipelinechannel--flip-coin-op-Output:\n          parameterType: STRING\n        pipelinechannel--get-random-int-op-Output:\n          parameterType: NUMBER_INTEGER\n        pipelinechannel--loop-item-param-2:\n          parameterType: STRING\n  comp-condition-6:\n    dag:\n      tasks:\n        print-op-3:\n          cachingOptions:\n            enableCache: true\n          componentRef:\n            name: comp-print-op-3\n          inputs:\n            parameters:\n              message:\n                runtimeValue:\n                  constant: \'{{$.inputs.parameters[\'\'pipelinechannel--loop-item-param-2\'\']}}\n                    and {{$.inputs.parameters[\'\'pipelinechannel--get-random-int-op-Output\'\']}}\n                    <= 5!\'\n              pipelinechannel--get-random-int-op-Output:\n                componentInputParameter: pipelinechannel--get-random-int-op-Output\n              pipelinechannel--loop-item-param-2:\n                componentInputParameter: pipelinechannel--loop-item-param-2\n          taskInfo:\n            name: print-op-3\n    inputDefinitions:\n      parameters:\n        pipelinechannel--flip-coin-op-Output:\n          parameterType: STRING\n        pipelinechannel--get-random-int-op-Output:\n          parameterType: NUMBER_INTEGER\n        pipelinechannel--loop-item-param-2:\n          parameterType: STRING\n  comp-exit-handler-1:\n    dag:\n      tasks:\n        fail-op:\n          cachingOptions:\n            enableCache: true\n          componentRef:\n            name: comp-fail-op\n          inputs:\n            parameters:\n              message:\n                runtimeValue:\n                  constant: Failing the run to demonstrate that exit handler still\n                    gets executed.\n          taskInfo:\n            name: fail-op\n  comp-fail-op:\n    executorLabel: exec-fail-op\n    inputDefinitions:\n      parameters:\n        message:\n          parameterType: STRING\n  comp-flip-coin-op:\n    executorLabel: exec-flip-coin-op\n    outputDefinitions:\n      parameters:\n        Output:\n          parameterType: STRING\n  comp-for-loop-3:\n    dag:\n      tasks:\n        condition-4:\n          componentRef:\n            name: comp-condition-4\n          inputs:\n            parameters:\n              pipelinechannel--flip-coin-op-Output:\n                componentInputParameter: pipelinechannel--flip-coin-op-Output\n              pipelinechannel--loop-item-param-2:\n                componentInputParameter: pipelinechannel--loop-item-param-2\n          taskInfo:\n            name: condition-4\n          triggerPolicy:\n            condition: inputs.parameter_values[\'pipelinechannel--loop-item-param-2\']\n              == inputs.parameter_values[\'pipelinechannel--flip-coin-op-Output\']\n    inputDefinitions:\n      parameters:\n        pipelinechannel--flip-coin-op-Output:\n          parameterType: STRING\n        pipelinechannel--loop-item-param-2:\n          parameterType: STRING\n  comp-get-random-int-op:\n    executorLabel: exec-get-random-int-op\n    inputDefinitions:\n      parameters:\n        maximum:\n          parameterType: NUMBER_INTEGER\n        minimum:\n          parameterType: NUMBER_INTEGER\n    outputDefinitions:\n      parameters:\n        Output:\n          parameterType: NUMBER_INTEGER\n  comp-print-op:\n    executorLabel: exec-print-op\n    inputDefinitions:\n      parameters:\n        message:\n          parameterType: STRING\n  comp-print-op-2:\n    executorLabel: exec-print-op-2\n    inputDefinitions:\n      parameters:\n        message:\n          parameterType: STRING\n  comp-print-op-3:\n    executorLabel: exec-print-op-3\n    inputDefinitions:\n      parameters:\n        message:\n          parameterType: STRING\ndeploymentSpec:\n  executors:\n    exec-fail-op:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - fail_op\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def fail_op(message: str):\n              \"\"\"Fails.\"\"\"\n              import sys\n              print(message)\n              sys.exit(1)\n\n        image: python:3.7\n    exec-flip-coin-op:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - flip_coin_op\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def flip_coin_op() -> str:\n              \"\"\"Flip a coin and output heads or tails randomly.\"\"\"\n              import random\n              result = random.choice([\'heads\', \'tails\'])\n              print(result)\n              return result\n\n        image: python:3.7\n    exec-get-random-int-op:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - get_random_int_op\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def get_random_int_op(minimum: int, maximum: int) -> int:\n              \"\"\"Generate a random number between minimum and maximum (inclusive).\"\"\"\n              import random\n              result = random.randint(minimum, maximum)\n              print(result)\n              return result\n\n        image: python:3.7\n    exec-print-op:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - print_op\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def print_op(message: str):\n              \"\"\"Print a message.\"\"\"\n              print(message)\n\n        image: python:3.7\n    exec-print-op-2:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - print_op\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def print_op(message: str):\n              \"\"\"Print a message.\"\"\"\n              print(message)\n\n        image: python:3.7\n    exec-print-op-3:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - print_op\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def print_op(message: str):\n              \"\"\"Print a message.\"\"\"\n              print(message)\n\n        image: python:3.7\npipelineInfo:\n  description: Shows how to use dsl.Condition(), dsl.ParallelFor, and dsl.ExitHandler().\n  name: tutorial-control-flows\nroot:\n  dag:\n    tasks:\n      exit-handler-1:\n        componentRef:\n          name: comp-exit-handler-1\n        taskInfo:\n          name: exit-handler-1\n      flip-coin-op:\n        cachingOptions:\n          enableCache: true\n        componentRef:\n          name: comp-flip-coin-op\n        taskInfo:\n          name: flip-coin-op\n      for-loop-3:\n        componentRef:\n          name: comp-for-loop-3\n        dependentTasks:\n        - flip-coin-op\n        inputs:\n          parameters:\n            pipelinechannel--flip-coin-op-Output:\n              taskOutputParameter:\n                outputParameterKey: Output\n                producerTask: flip-coin-op\n        parameterIterator:\n          itemInput: pipelinechannel--loop-item-param-2\n          items:\n            raw: \'[\"heads\", \"tails\"]\'\n        taskInfo:\n          name: for-loop-3\n      print-op:\n        cachingOptions:\n          enableCache: true\n        componentRef:\n          name: comp-print-op\n        dependentTasks:\n        - exit-handler-1\n        inputs:\n          parameters:\n            message:\n              runtimeValue:\n                constant: Exit handler has worked!\n        taskInfo:\n          name: print-op\n        triggerPolicy:\n          strategy: ALL_UPSTREAM_TASKS_COMPLETED\nschemaVersion: 2.1.0\nsdkVersion: kfp-2.0.0-rc.1\n',''),('9e376f66-f496-43a9-be4d-0b48b7aa036b',1760607062,'[Tutorial] Data passing in python components','[]','4e9ca692-2f65-4b54-8ac4-e826bf092fd0','READY','','[source code](https://github.com/kubeflow/pipelines/tree/e03e31219387b587b700ba3e31a02df486aa364f/samples/tutorials/Data%20passing%20in%20python%20components) Shows how to pass data between python components.','components:\n  comp-preprocess:\n    executorLabel: exec-preprocess\n    inputDefinitions:\n      parameters:\n        message:\n          parameterType: STRING\n    outputDefinitions:\n      artifacts:\n        output_dataset_one:\n          artifactType:\n            schemaTitle: system.Dataset\n            schemaVersion: 0.0.1\n        output_dataset_two_path:\n          artifactType:\n            schemaTitle: system.Dataset\n            schemaVersion: 0.0.1\n      parameters:\n        output_bool_parameter_path:\n          parameterType: BOOLEAN\n        output_dict_parameter_path:\n          parameterType: STRUCT\n        output_list_parameter_path:\n          parameterType: LIST\n        output_parameter_path:\n          parameterType: STRING\n  comp-train:\n    executorLabel: exec-train\n    inputDefinitions:\n      artifacts:\n        dataset_one_path:\n          artifactType:\n            schemaTitle: system.Dataset\n            schemaVersion: 0.0.1\n        dataset_two:\n          artifactType:\n            schemaTitle: system.Dataset\n            schemaVersion: 0.0.1\n      parameters:\n        input_bool:\n          parameterType: BOOLEAN\n        input_dict:\n          parameterType: STRUCT\n        input_list:\n          parameterType: LIST\n        message:\n          parameterType: STRING\n        num_steps:\n          defaultValue: 100\n          isOptional: true\n          parameterType: NUMBER_INTEGER\n    outputDefinitions:\n      artifacts:\n        model:\n          artifactType:\n            schemaTitle: system.Model\n            schemaVersion: 0.0.1\ndeploymentSpec:\n  executors:\n    exec-preprocess:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - preprocess\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def preprocess(\n              # An input parameter of type string.\n              message: str,\n              # Use Output[T] to get a metadata-rich handle to the output artifact\n              # of type `Dataset`.\n              output_dataset_one: Output[Dataset],\n              # A locally accessible filepath for another output artifact of type\n              # `Dataset`.\n              output_dataset_two_path: OutputPath(\'Dataset\'),\n              # A locally accessible filepath for an output parameter of type string.\n              output_parameter_path: OutputPath(str),\n              # A locally accessible filepath for an output parameter of type bool.\n              output_bool_parameter_path: OutputPath(bool),\n              # A locally accessible filepath for an output parameter of type dict.\n              output_dict_parameter_path: OutputPath(Dict[str, int]),\n              # A locally accessible filepath for an output parameter of type list.\n              output_list_parameter_path: OutputPath(List[str]),\n          ):\n              \"\"\"Dummy preprocessing step.\"\"\"\n\n              # Use Dataset.path to access a local file path for writing.\n              # One can also use Dataset.uri to access the actual URI file path.\n              with open(output_dataset_one.path, \'w\') as f:\n                  f.write(message)\n\n              # OutputPath is used to just pass the local file path of the output artifact\n              # to the function.\n              with open(output_dataset_two_path, \'w\') as f:\n                  f.write(message)\n\n              with open(output_parameter_path, \'w\') as f:\n                  f.write(message)\n\n              with open(output_bool_parameter_path, \'w\') as f:\n                  f.write(\n                      str(True))  # use either `str()` or `json.dumps()` for bool values.\n\n              import json\n              with open(output_dict_parameter_path, \'w\') as f:\n                  f.write(json.dumps({\'A\': 1, \'B\': 2}))\n\n              with open(output_list_parameter_path, \'w\') as f:\n                  f.write(json.dumps([\'a\', \'b\', \'c\']))\n\n        image: python:3.7\n    exec-train:\n      container:\n        args:\n        - --executor_input\n        - \'{{$}}\'\n        - --function_to_execute\n        - train\n        command:\n        - sh\n        - -c\n        - |2\n\n          if ! [ -x \"$(command -v pip)\" ]; then\n              python3 -m ensurepip || python3 -m ensurepip --user || apt-get install python3-pip\n          fi\n\n          PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --quiet     --no-warn-script-location \'kfp==2.0.0-rc.1\' && \"$0\" \"$@\"\n        - sh\n        - -ec\n        - |\n          program_path=$(mktemp -d)\n          printf \"%s\" \"$0\" > \"$program_path/ephemeral_component.py\"\n          python3 -m kfp.components.executor_main                         --component_module_path                         \"$program_path/ephemeral_component.py\"                         \"$@\"\n        - |2+\n\n          import kfp\n          from kfp import dsl\n          from kfp.dsl import *\n          from typing import *\n\n          def train(\n              # Use InputPath to get a locally accessible path for the input artifact\n              # of type `Dataset`.\n              dataset_one_path: InputPath(\'Dataset\'),\n              # Use Input[T] to get a metadata-rich handle to the input artifact\n              # of type `Dataset`.\n              dataset_two: Input[Dataset],\n              # An input parameter of type string.\n              message: str,\n              # Use Output[T] to get a metadata-rich handle to the output artifact\n              # of type `Model`.\n              model: Output[Model],\n              # An input parameter of type bool.\n              input_bool: bool,\n              # An input parameter of type dict.\n              input_dict: Dict[str, int],\n              # An input parameter of type List[str].\n              input_list: List[str],\n              # An input parameter of type int with a default value.\n              num_steps: int = 100,\n          ):\n              \"\"\"Dummy Training step.\"\"\"\n              with open(dataset_one_path, \'r\') as input_file:\n                  dataset_one_contents = input_file.read()\n\n              with open(dataset_two.path, \'r\') as input_file:\n                  dataset_two_contents = input_file.read()\n\n              line = (f\'dataset_one_contents: {dataset_one_contents} || \'\n                      f\'dataset_two_contents: {dataset_two_contents} || \'\n                      f\'message: {message} || \'\n                      f\'input_bool: {input_bool}, type {type(input_bool)} || \'\n                      f\'input_dict: {input_dict}, type {type(input_dict)} || \'\n                      f\'input_list: {input_list}, type {type(input_list)} \\n\')\n\n              with open(model.path, \'w\') as output_file:\n                  for i in range(num_steps):\n                      output_file.write(\'Step {}\\n{}\\n=====\\n\'.format(i, line))\n\n              # model is an instance of Model artifact, which has a .metadata dictionary\n              # to store arbitrary metadata for the output artifact.\n              model.metadata[\'accuracy\'] = 0.9\n\n        image: python:3.7\npipelineInfo:\n  name: tutorial-data-passing\nroot:\n  dag:\n    tasks:\n      preprocess:\n        cachingOptions:\n          enableCache: true\n        componentRef:\n          name: comp-preprocess\n        inputs:\n          parameters:\n            message:\n              componentInputParameter: message\n        taskInfo:\n          name: preprocess\n      train:\n        cachingOptions:\n          enableCache: true\n        componentRef:\n          name: comp-train\n        dependentTasks:\n        - preprocess\n        inputs:\n          artifacts:\n            dataset_one_path:\n              taskOutputArtifact:\n                outputArtifactKey: output_dataset_one\n                producerTask: preprocess\n            dataset_two:\n              taskOutputArtifact:\n                outputArtifactKey: output_dataset_two_path\n                producerTask: preprocess\n          parameters:\n            input_bool:\n              taskOutputParameter:\n                outputParameterKey: output_bool_parameter_path\n                producerTask: preprocess\n            input_dict:\n              taskOutputParameter:\n                outputParameterKey: output_dict_parameter_path\n                producerTask: preprocess\n            input_list:\n              taskOutputParameter:\n                outputParameterKey: output_list_parameter_path\n                producerTask: preprocess\n            message:\n              taskOutputParameter:\n                outputParameterKey: output_parameter_path\n                producerTask: preprocess\n        taskInfo:\n          name: train\n  inputDefinitions:\n    parameters:\n      message:\n        defaultValue: message\n        isOptional: true\n        parameterType: STRING\nschemaVersion: 2.1.0\nsdkVersion: kfp-2.0.0-rc.1\n','');
/*!40000 ALTER TABLE `pipeline_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pipelines`
--

DROP TABLE IF EXISTS `pipelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pipelines` (
  `UUID` varchar(255) NOT NULL,
  `CreatedAtInSec` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Status` varchar(255) NOT NULL,
  `DefaultVersionId` varchar(255) DEFAULT NULL,
  `Namespace` varchar(63) DEFAULT NULL,
  PRIMARY KEY (`UUID`),
  UNIQUE KEY `namespace_name` (`Name`,`Namespace`),
  UNIQUE KEY `name_namespace_index` (`Name`,`Namespace`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pipelines`
--

LOCK TABLES `pipelines` WRITE;
/*!40000 ALTER TABLE `pipelines` DISABLE KEYS */;
INSERT INTO `pipelines` VALUES ('4e9ca692-2f65-4b54-8ac4-e826bf092fd0',1760607062,'[Tutorial] Data passing in python components','[source code](https://github.com/kubeflow/pipelines/tree/e03e31219387b587b700ba3e31a02df486aa364f/samples/tutorials/Data%20passing%20in%20python%20components) Shows how to pass data between python components.','','READY','',''),('80e9ab7f-ae28-4801-82af-564a078c62c3',1760607063,'[Tutorial] DSL - Control structures','[source code](https://github.com/kubeflow/pipelines/tree/e03e31219387b587b700ba3e31a02df486aa364f/samples/tutorials/DSL%20-%20Control%20structures) Shows how to use conditional execution and exit handlers. This pipeline will randomly fail to demonstrate that the exit handler gets executed even in case of failure.','','READY','','');
/*!40000 ALTER TABLE `pipelines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_references`
--

DROP TABLE IF EXISTS `resource_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_references` (
  `ResourceUUID` varchar(255) NOT NULL,
  `ResourceType` varchar(255) NOT NULL,
  `ReferenceUUID` varchar(255) NOT NULL,
  `ReferenceName` varchar(255) NOT NULL,
  `ReferenceType` varchar(255) NOT NULL,
  `Relationship` varchar(255) NOT NULL,
  `Payload` longtext NOT NULL,
  PRIMARY KEY (`ResourceUUID`,`ResourceType`,`ReferenceType`),
  KEY `referencefilter` (`ResourceType`,`ReferenceUUID`,`ReferenceType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_references`
--

LOCK TABLES `resource_references` WRITE;
/*!40000 ALTER TABLE `resource_references` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `run_details`
--

DROP TABLE IF EXISTS `run_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `run_details` (
  `UUID` varchar(255) NOT NULL,
  `DisplayName` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Namespace` varchar(255) NOT NULL,
  `ExperimentUUID` varchar(255) NOT NULL,
  `JobUUID` varchar(255) DEFAULT NULL,
  `StorageState` varchar(255) NOT NULL,
  `ServiceAccount` varchar(255) NOT NULL,
  `PipelineId` varchar(255) NOT NULL,
  `PipelineVersionId` varchar(255) DEFAULT NULL,
  `PipelineName` varchar(255) NOT NULL,
  `PipelineSpecManifest` longtext,
  `WorkflowSpecManifest` longtext NOT NULL,
  `Parameters` longtext,
  `RuntimeParameters` longtext,
  `PipelineRoot` longtext,
  `CreatedAtInSec` bigint(20) NOT NULL,
  `ScheduledAtInSec` bigint(20) DEFAULT '0',
  `FinishedAtInSec` bigint(20) DEFAULT '0',
  `Conditions` varchar(255) NOT NULL,
  `State` varchar(255) DEFAULT NULL,
  `StateHistory` longtext,
  `PipelineRuntimeManifest` longtext NOT NULL,
  `WorkflowRuntimeManifest` longtext NOT NULL,
  `PipelineContextId` bigint(20) DEFAULT '0',
  `PipelineRunContextId` bigint(20) DEFAULT '0',
  PRIMARY KEY (`UUID`),
  KEY `experimentuuid_createatinsec` (`ExperimentUUID`,`CreatedAtInSec`),
  KEY `experimentuuid_conditions_finishedatinsec` (`ExperimentUUID`,`Conditions`,`FinishedAtInSec`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `run_details`
--

LOCK TABLES `run_details` WRITE;
/*!40000 ALTER TABLE `run_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `run_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `run_metrics`
--

DROP TABLE IF EXISTS `run_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `run_metrics` (
  `RunUUID` varchar(255) NOT NULL,
  `NodeID` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `NumberValue` double DEFAULT NULL,
  `Format` varchar(255) DEFAULT NULL,
  `Payload` longtext NOT NULL,
  PRIMARY KEY (`RunUUID`,`NodeID`,`Name`),
  CONSTRAINT `run_metrics_RunUUID_run_details_UUID_foreign` FOREIGN KEY (`RunUUID`) REFERENCES `run_details` (`UUID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `run_metrics`
--

LOCK TABLES `run_metrics` WRITE;
/*!40000 ALTER TABLE `run_metrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `run_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `UUID` varchar(255) NOT NULL,
  `Namespace` varchar(255) NOT NULL,
  `PipelineName` varchar(255) NOT NULL,
  `RunUUID` varchar(255) NOT NULL,
  `PodName` varchar(255) NOT NULL,
  `MLMDExecutionID` varchar(255) NOT NULL,
  `CreatedTimestamp` bigint(20) NOT NULL,
  `StartedTimestamp` bigint(20) DEFAULT '0',
  `FinishedTimestamp` bigint(20) DEFAULT '0',
  `Fingerprint` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `ParentTaskUUID` varchar(255) DEFAULT NULL,
  `State` varchar(255) DEFAULT NULL,
  `StateHistory` longtext,
  `MLMDInputs` longtext,
  `MLMDOutputs` longtext,
  `ChildrenPods` longtext,
  `Payload` longtext,
  PRIMARY KEY (`UUID`),
  KEY `tasks_RunUUID_run_details_UUID_foreign` (`RunUUID`),
  CONSTRAINT `tasks_RunUUID_run_details_UUID_foreign` FOREIGN KEY (`RunUUID`) REFERENCES `run_details` (`UUID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-16 11:01:59
