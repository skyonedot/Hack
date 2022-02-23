// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

interface IAir {
    function mintNFT(uint256 num) payable external;
    function safeTransferFrom(address from,address to,uint256 tokenId) external;
}


//部署这个类
contract batch_claim_token is IERC721Receiver  {

    constructor(){}

    //调用这个函数，参数就是领取数量
    function attack(uint256 amount,address token) public{
        for (uint i = 0; i <amount;i++)
        {
            IAir(token).mintNFT(1);
        }
        
    }

    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function withdraw(uint256 start,uint256 end) public {
        for(uint i=start;i<end;i++){
            IAir(0x1E5279826D9863C5Ef7E16b94acAc1daD15A94f0).safeTransferFrom(address(this),0x8a09FB23E1c8d0FF9c9Fef0BcFc9b9e07B1f0667,i);
        }
    }
}