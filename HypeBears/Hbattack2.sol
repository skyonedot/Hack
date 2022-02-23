// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAir {
    function mintNFT(uint256 num) payable external;
    function safeTransferFrom(address from,address to,uint256 tokenId) external;
}



//部署这个类
contract batch_claim_token  {
    constructor(address token,uint256 amount){
        for (uint i = 0; i <amount;i++){
            IAir(token).mintNFT(1);
        }
        //IAir(token).mintNFT(1);
    }

    // //调用这个函数，参数就是领取数量
    // function attack(address token) public{
    //     // for (uint i = 0; i <amount;i++)
    //     // {
    //     //     IAir(token).mintNFT(1);
    //     // }
        
    // }

    function withdraw(uint256 start,uint256 end) public {
        for(uint i=start;i<end;i++){
            IAir(0x1dC298326d7EB837870574Ef82FbE98940A4bd03).safeTransferFrom(address(this),0x8a09FB23E1c8d0FF9c9Fef0BcFc9b9e07B1f0667,i);
        }
    }
}