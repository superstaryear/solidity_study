// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//openzeppelin版本 5.4.0
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";

/*
### ✅ 作业2：在测试网上发行一个图文并茂的 NFT
任务目标
1. 使用 Solidity 编写一个符合 ERC721 标准的 NFT 合约。
2. 将图文数据上传到 IPFS，生成元数据链接。
3. 将合约部署到以太坊测试网（如 Goerli 或 Sepolia）。
4. 铸造 NFT 并在测试网环境中查看。
任务步骤
1. 编写 NFT 合约
  - 使用 OpenZeppelin 的 ERC721 库编写一个 NFT 合约。
  - 合约应包含以下功能：
  - 构造函数：设置 NFT 的名称和符号。
  - mintNFT 函数：允许用户铸造 NFT，并关联元数据链接（tokenURI）。
  - 在 Remix IDE 中编译合约。
2. 准备图文数据
  - 准备一张图片，并将其上传到 IPFS（可以使用 Pinata 或其他工具）。
  - 创建一个 JSON 文件，描述 NFT 的属性（如名称、描述、图片链接等）。
  - 将 JSON 文件上传到 IPFS，获取元数据链接。
  - JSON文件参考 https://docs.opensea.io/docs/metadata-standards
3. 部署合约到测试网
  - 在 Remix IDE 中连接 MetaMask，并确保 MetaMask 连接到 Goerli 或 Sepolia 测试网。
  - 部署 NFT 合约到测试网，并记录合约地址。
4. 铸造 NFT
  - 使用 mintNFT 函数铸造 NFT：
  - 在 recipient 字段中输入你的钱包地址。
  - 在 tokenURI 字段中输入元数据的 IPFS 链接。
  - 在 MetaMask 中确认交易。
5. 查看 NFT
  - 打开 OpenSea 测试网 或 Etherscan 测试网。
  - 连接你的钱包，查看你铸造的 NFT。
  图片地址：          https://brown-given-guanaco-730.mypinata.cloud/ipfs/bafkreigx236ravmrbddicdflsyxidpob34rwdofog2j6wvygmb57zst24e
  测试区块链交易地址： https://eth-sepolia.blockscout.com/tx/0x5c62269b7a7727f6e7f01b4f1c7819dac81d74e9b7f8bcb5f8d55727f5e5992f
*/

// 继承 ERC721URIStorage 而不是 ERC721
contract MyNFT is ERC721URIStorage,Ownable {
    
    //tokenId序号
    uint private _tokenIdCounter;

    //在这里设置 NFT 名称和符号
    constructor() ERC721("MyYearNTF","YNFT") Ownable(msg.sender){

    }
    
    //安全的铸造函数，只有合约所有者可以调用
    function safeMint(address to,string memory uri) public onlyOwner{
        uint tokenId = _tokenIdCounter++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId,uri);
    }

    //重写 baseTokenURI
    function _baseURI() internal pure override returns(string memory){
        return "https://brown-given-guanaco-730.mypinata.cloud/ipfs/";
    }

}