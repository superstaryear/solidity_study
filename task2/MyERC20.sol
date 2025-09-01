// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;




/*
作业 1：ERC20 代币
任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
合约包含以下标准 ERC20 功能：
balanceOf：查询账户余额。
transfer：转账。
approve 和 transferFrom：授权和代扣转账。
使用 event 记录转账和授权操作。
提供 mint 函数，允许合约所有者增发代币。
提示：
使用 mapping 存储账户余额和授权信息。
使用 event 定义 Transfer 和 Approval 事件。
部署到sepolia 测试网，导入到自己的钱包
*/
contract MyERC20 {

    //代币账户余额映射
    mapping (address account => uint balance) private _balances;

    //代币委托支付映射 所有者（owner）、授权者（spender）、授权金额（amount）
    mapping (address account => mapping (address spender => uint amount)) _allowances;

    address private _owner;

    uint private _totalSupply =  2 * 10**18;

    /*
    转账事件
     */
    event Transfer(address indexed from ,address indexed to,uint amount);

    /*
    授权事件
    */ 
    event Approval(address indexed owner,address indexed spender,uint amount);

    modifier onlyOwner(){
        require(msg.sender == _owner,"only me can call this function");
        _; 
    }

    constructor(){
        _owner = msg.sender;
        //分配初始供应量
        // _balances[_owner] = _totalSupply
    }

    /*
    货币名称
    */
    function name() public view virtual returns (string memory){
        return "YT Protocol";
    }

    /*
    货币符号
    */
    function symbol() public view virtual returns (string memory){
        return "YTP";
    }

    /*
    货币精度单位
    */
    function decimals() public view virtual returns (uint8){
        return 18;
    }

    /*
    货币总供应量
    */
    function totalSupply() public view virtual returns (uint256){
        return _totalSupply;
    }

    /*
    查询账户余额
    */
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    /*
    转账
    */ 
    function transfer(address to,uint amount) external returns (bool){
        require(to!=address(0),"address not allow");
        require(_balances[msg.sender]>=amount,"balance not enough");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to,amount);
        return true;
    }


    /*
    授权
    */
    function approve(address spender,uint amount) external returns(bool){
        require(spender!=address(0),"address not allow");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /*
    查询授信金额
    */
    function allowance(address from,address spender) public view returns(uint){
        return _allowances[from][spender];
    }

    /*
    代扣转账
    */ 
    function transferFrom(address from, address to,uint amount) external returns(bool){
        require(_balances[from]>=amount,"balance not enough");
        require(_allowances[from][msg.sender]>=amount,"allowances not enough");
        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;
        emit Transfer(from,to,amount);
        return true;
    }

    /*
    铸币
    */
    function mint(address to ,uint amount) public onlyOwner{
        require(to!=address(0),"address not allow");
        _balances[to] += amount;
    }


}