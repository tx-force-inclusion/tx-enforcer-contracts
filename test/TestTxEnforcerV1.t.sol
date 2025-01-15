// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Test} from "forge-std/Test.sol";
import {TxEnforcerV1} from "../src/TxEnforcerV1.sol";
import {DeployTxEnforcerV1} from "../script/DeployTxEnforcerV1.s.sol";

contract TestTxEnforcerV1 is Test {
    TxEnforcerV1 txEnforcerV1;

    address constant L1OptimismSepoliaAddress = 0x16Fc5058F25648194471939df75CF27A2fdC48BC;

    address constant L2ContractAddressNonPayable = 0x4Da9B696A32c63Cc323815e235BEfe8f238b33EE;

    address constant L2ContractAddress = 0xCe4258B32697315466E78b6a01038D5cd6e4e34c;

    address constant RECEIVER_ADDRESS = 0x23d3957BE879aBa6ca925Ee4F072d1A8C4E8c890;

    uint256 constant VALUE = 0.00001 ether;

    uint256 constant AMOUNT_TO_MINT = 10000000000000000000;

    uint64 constant  GAS_LIMIT = 1000000;

    bool constant IS_CREATION = false;

    address constant SENDER = 0x23d3957BE879aBa6ca925Ee4F072d1A8C4E8c890;

    event TxForwarded(
        address indexed sender,
        address indexed portal,
        address indexed to,
        uint256 value,
        uint64 gasLimit,
        bool isCreation,
        bytes data
    );

    function setUp() public {
        DeployTxEnforcerV1 deployTxEnforcerV1 = new DeployTxEnforcerV1();
        txEnforcerV1 = deployTxEnforcerV1.run();
    }

    function testForwardDepositTxOpSepolia() public returns (bytes memory) {
        bytes memory data = abi.encodeWithSignature("mint(address,uint256)", RECEIVER_ADDRESS, AMOUNT_TO_MINT);

        vm.expectEmit(true, true, true, false, address(txEnforcerV1));
        emit TxForwarded(msg.sender, L1OptimismSepoliaAddress, L2ContractAddress, VALUE, GAS_LIMIT, IS_CREATION, data);

        vm.prank(SENDER);
        txEnforcerV1.forwardDepositTx(L1OptimismSepoliaAddress, L2ContractAddress, VALUE, GAS_LIMIT, IS_CREATION, data);

        return data;
    }
}