// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./IOptimismPortal.sol";

/**
 * @title TxEnforcerV1
 * @notice A minimal contract that forwards user requests into the OptimismPortal's
 */
contract TxEnforcerV1 {
    event TxForwarded(
        address indexed sender,
        address indexed portal,
        address indexed to,
        uint256 value,
        uint64 gasLimit,
        bool isCreation,
        bytes data
    );

    /**
     * @notice Forwards parameters to the OptimismPortal's depositTransaction(...) function.
     * @param _portal     Address of the OptimismPortal contract on L1.
     * @param _to         The L2 address to receive the transaction.
     * @param _value      ETH value (in wei) to send on L2.
     * @param _gasLimit   The L2 gas limit for the transaction.
     * @param _isCreation Whether this is creating a contract on L2 (true) or calling an existing contract (false).
     * @param _data       Calldata to send to the target on L2.
     */
    function forwardDepositTx(
        address _portal,
        address _to,
        uint256 _value,
        uint64 _gasLimit,
        bool _isCreation,
        bytes calldata _data
    )
        external
        payable
    {
        IOptimismPortal(_portal).depositTransaction{value: msg.value}(
            _to,
            _value,
            _gasLimit,
            _isCreation,
            _data
        );

        emit TxForwarded(
            msg.sender,
            _portal,
            _to,
            _value,
            _gasLimit,
            _isCreation,
            _data
        );
    }
}
