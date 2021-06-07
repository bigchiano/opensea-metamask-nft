// SPDX-License-Identifier: UNLICENSED

pragma solidity =0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandNft is ERC721 {
    using SafeMath for uint256;
    using Strings for uint256;

    string private _uri;
    uint256 public cards;

    event MintNft(address to, uint256 id);
    event BurnNft(address from, uint256 id);

    constructor() ERC721("Rand Nft", "RNT") {
        setURI("https://randnfts.herokuapp.com/nft-api/");
    }

        function _baseURI() internal view virtual override returns (string memory) {
        return _uri;
    }

    function uri(uint256) public view virtual returns (string memory) {
        return _uri;
    }

    function setURI(string memory newuri) public {
        _uri = newuri;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, tokenId.toString()))
            : '';
    }

    function mint(
        address to,
        uint256 id
    ) public {
        _mint(to, id);
        emit MintNft(to, id);
    }

    function burn(uint256 id) public {
        _burn(id);
        emit BurnNft(_msgSender(), id);
    }
}
