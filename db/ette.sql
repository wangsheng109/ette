/*
 Navicat MySQL Data Transfer

 Source Server         : 悉尼服务器
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : 13.210.52.1:3306
 Source Schema         : ette

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 16/01/2022 16:48:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


create DATABASE ette;
use ette;
-- ----------------------------
-- Table structure for blocks
-- ----------------------------
DROP TABLE IF EXISTS `blocks`;
CREATE TABLE `blocks`  (
  `hash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `number` bigint(20) NOT NULL,
  `time` bigint(20) NOT NULL,
  `parenthash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `difficulty` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gasused` bigint(20) NOT NULL,
  `gaslimit` bigint(20) NOT NULL,
  `nonce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `miner` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `size` float NOT NULL,
  `stateroothash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unclehash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `txroothash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `receiptroothash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `extradata` blob NULL,
  `inputdata` blob NULL,
  `tx_num` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hash`) USING BTREE,
  UNIQUE INDEX `number`(`number`) USING BTREE,
  UNIQUE INDEX `number_2`(`number`) USING BTREE,
  INDEX `idx_blocks_number`(`number`) USING BTREE,
  INDEX `idx_blocks_time`(`time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_vars
-- ----------------------------
DROP TABLE IF EXISTS `config_vars`;
CREATE TABLE `config_vars`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for delivery_history
-- ----------------------------
DROP TABLE IF EXISTS `delivery_history`;
CREATE TABLE `delivery_history`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `endpoint` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datalength` bigint(20) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `origin` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `index` bigint(20) NOT NULL,
  `topics`  blob NULL,
  `data` blob NULL,
  `txhash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blockhash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `idx_events_origin`(`origin`) USING BTREE,
  INDEX `idx_events_transaction_hash`(`txhash`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ifi_award_log
-- ----------------------------
DROP TABLE IF EXISTS `ifi_award_log`;
CREATE TABLE `ifi_award_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `node_address` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '节点地址',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0来源于CPU，1来源于voyager提现',
  `from_account` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '激励来源账号',
  `ifi_amount` bigint(60) NULL DEFAULT NULL COMMENT '奖励数量',
  `timestamp` int(11) NULL DEFAULT NULL COMMENT '时间戳',
  `tx_hash` varchar(88) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '交易哈希',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80153 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for nodes
-- ----------------------------
DROP TABLE IF EXISTS `nodes`;
CREATE TABLE `nodes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `chequebook_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cpu_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cpu_score` bigint(60) NULL DEFAULT NULL,
  `local_ip` varchar(55) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `incentive_reward` bigint(60) NOT NULL DEFAULT 0 COMMENT 'voyager提现奖励',
  `total_reward` bigint(60) NOT NULL DEFAULT 0 COMMENT '总奖励数量',
  `reward_30days` bigint(60) NOT NULL DEFAULT 0 COMMENT '30天内奖励数量',
  `increase_ratio` int(11) NOT NULL DEFAULT 0 COMMENT '增长幅度',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for nodes_startup
-- ----------------------------
DROP TABLE IF EXISTS `nodes_startup`;
CREATE TABLE `nodes_startup`  (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `owner_address` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `chequebook_address` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `local_ip` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `startup_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 177 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for signers
-- ----------------------------
DROP TABLE IF EXISTS `signers`;
CREATE TABLE `signers`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(78) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ip` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `min_block` bigint(20) NOT NULL DEFAULT 0 COMMENT '最小签名区块',
  `max_block` bigint(20) NOT NULL DEFAULT 0 COMMENT '最大签名区块',
  `days7` bigint(20) NOT NULL DEFAULT 0 COMMENT '7天内签名区块数量',
  `days30` bigint(20) NOT NULL DEFAULT 0 COMMENT '30天内签名区块数量',
  `total_blocks` int(11) NOT NULL DEFAULT 0 COMMENT '签名区块的总数量',
  `latitude` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `longitude` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_time` datetime NOT NULL,
  `country` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for subscription_details
-- ----------------------------
DROP TABLE IF EXISTS `subscription_details`;
CREATE TABLE `subscription_details`  (
  `address` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subscriptionplan` int(11) NOT NULL,
  PRIMARY KEY (`address`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for subscription_plans
-- ----------------------------
DROP TABLE IF EXISTS `subscription_plans`;
CREATE TABLE `subscription_plans`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `deliverycount` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `deliverycount`(`deliverycount`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `hash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `from` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contract` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `data` blob NULL,
  `input_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `gas` bigint(20) NOT NULL,
  `gasprice` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cost` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nonce` bigint(20) NOT NULL,
  `state` smallint(6) NOT NULL,
  `blockhash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blockNumber` bigint(20) NOT NULL DEFAULT 0,
  `timestamp` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`hash`) USING BTREE,
  INDEX `idx_transactions_from`(`from`) USING BTREE,
  INDEX `idx_transactions_to`(`to`) USING BTREE,
  INDEX `idx_transactions_contract`(`contract`) USING BTREE,
  INDEX `idx_transactions_nonce`(`nonce`) USING BTREE,
  INDEX `idx_transactions_block_hash`(`blockhash`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transactions_dam
-- ----------------------------
DROP TABLE IF EXISTS `transactions_dam`;
CREATE TABLE `transactions_dam`  (
  `hash` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `from` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ifi_amount` bigint(20) NOT NULL,
  `timestamp` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`hash`) USING BTREE,
  INDEX `idx_transactions_dam_from`(`from`) USING BTREE,
  INDEX `idx_transactions_dam_to`(`to`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `address` char(42) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apikey` char(66) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`apikey`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
