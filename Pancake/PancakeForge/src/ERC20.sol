// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {ERC20} from "openzeppelin-contracts/token/ERC20/ERC20.sol";

contract MyERC20 is ERC20 {
    constructor() ERC20("SKYONE", "SO") {
        this;
    }

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
}
