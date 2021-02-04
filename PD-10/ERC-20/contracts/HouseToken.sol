// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HouseToken is ERC20 {

    /// @dev Constructor that gives _msgSender() all of existing tokens.
    constructor () ERC20("HouseToken", "HOUSE") {
        _mint(msg.sender, 475368);
    }
}