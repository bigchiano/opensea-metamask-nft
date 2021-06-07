// SPDX-License-Identifier: UNLICENSED

pragma solidity =0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandNft is ERC1155 {
    using SafeMath for uint256;

    constructor() ERC1155("https://randnfts.herokuapp.com/nft-api/") {}

    uint256 public cards;
    mapping(uint256 => uint256) public totalSupply;
    mapping(uint256 => uint256) public circulatingSupply;

    event CardAdded(uint256 id, uint256 maxSupply);
    event MintNft(address to, uint256 id, uint256 amount);
    event BurnNft(address from, uint256 id, uint256 amount);

    function addCard(uint256 maxSupply) public returns (uint256) {
        require(maxSupply > 0, "Maximum supply can not be 0");
        cards = cards.add(1);
        totalSupply[cards] = maxSupply;
        emit CardAdded(cards, maxSupply);
        return cards;
    }

    function mint(
        address to,
        uint256 id,
        uint256 amount
    ) public {
        require(
            circulatingSupply[id].add(amount) <= totalSupply[id],
            "Total supply reached."
        );
        circulatingSupply[id] = circulatingSupply[id].add(amount);
        _mint(to, id, amount, "");
        emit MintNft(to, id, amount);
    }

    function burn(uint256 id, uint256 amount) public {
        _burn(_msgSender(), id, amount);
        emit BurnNft(_msgSender(), id, amount);
    }
}
