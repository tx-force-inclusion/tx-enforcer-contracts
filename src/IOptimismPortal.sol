// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IOptimismPortal {
    function depositTransaction(
        address _to,
        uint256 _value,
        uint64 _gasLimit,
        bool _isCreation,
        bytes calldata _data
    ) external payable;
}
