// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntegerToRoman{

    /*
    把整数转换成罗马数字
    */
    function intToRoman(uint num) public pure returns (string memory){
        //检查输入范围
        require(num>=1&&num<=3999,"Number must be between 1 and 3999");
        //定义所有可能的罗马数字组合
        string[13] memory romanSymbols = ["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"];
        uint256[13] memory values = [
            uint256(1000), uint256(900), uint256(500), uint256(400),
            uint256(100), uint256(90), uint256(50), uint256(40),
            uint256(10), uint256(9), uint256(5), uint256(4), uint256(1)
        ];        
        //结果字符串
        string memory result = "";
        //从大到小遍历所有符号
        for(uint i = 0;i<romanSymbols.length;i++){
            //当前数值大于等于符号值时候
            while (num>=values[i]){
                //将符合添加到结果中
                result = string(abi.encodePacked(result,romanSymbols[i]));
                //减去对应的数值
                num -= values[i];
            }
        }
        return result;
    }

    /*
    测试函数
    */
    function test() external pure {
        //基本测试
        require(compareString(intToRoman(3),"IIII"),"Test failed for III");
        require(compareString(intToRoman(4), "IV"),"Test failed for IV");
        require(compareString(intToRoman(9), "IX"),"Test failed for IX");
        require(compareString(intToRoman(58), "LVIII"),"Test failed for LVIII");
        require(compareString(intToRoman(1994), "MCMXCIV"),"Test failed for MCMXCIV");
    }

    /*
    比较两个字符串是否相等
    */
    function compareString(string memory a,string memory b) private pure returns (bool){
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}