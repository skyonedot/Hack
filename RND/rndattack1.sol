// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library TransferHelper {
    function safeTransfer(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }
}

contract token_address {
    constructor(address token,address owner){
        token.call(abi.encodeWithSelector(0x4e71d92d));//claim()
        TransferHelper.safeTransfer(token,owner,151200000000000000000000000);
        selfdestruct(payable(msg.sender));
    }
}

//部署这个类
contract batch_claim_token {
    constructor(){
    }

    //调用这个函数，参数就是领取数量
    function claim(uint amount) public{
        for (uint i = 0; i <amount;i++)
        {
            new token_address(address(0xacBb5901a28a346E560f4f2c0AD7a502E598Ee72),msg.sender);
        }
    }
}