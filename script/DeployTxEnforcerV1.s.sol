// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script} from "forge-std/Script.sol";
import {TxEnforcerV1} from "../src/TxEnforcerV1.sol";

contract DeployTxEnforcerV1 is Script {
    function run() external returns (TxEnforcerV1) {
        vm.startBroadcast();
        TxEnforcerV1 txEnforcerV1 = new TxEnforcerV1();
        vm.stopBroadcast();

        return txEnforcerV1;
    }
}