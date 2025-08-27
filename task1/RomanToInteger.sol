// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInterger{

    /*
    获取罗马数字映射
    */
    function getRomanValue(bytes1 c) private pure returns (uint){
        if (c == 'I') return 1;
        if (c == 'V') return 5;
        if (c == 'X') return 10;
        if (c == 'L') return 50;
        if (c == 'C') return 100;
        if (c == 'D') return 500;
        if (c == 'M') return 1000;
        revert("Invalid Roman numeral");
    }

    /*
    罗马数转化为数字
    */
    function romanToInt(string memory input) public pure returns (uint){
        bytes memory inputBytes = bytes(input);
        uint len = inputBytes.length;
        uint res = 0;
        for (uint i=0;i<len;i++){
            uint cur = getRomanValue(inputBytes[i]);
            if (i+1<len){
                uint next = getRomanValue(inputBytes[i+1]);
                if (cur<next){
                    res+= next -cur;
                    i++;
                    continue ;
                }
            }
            res += cur;
        }
        return res;
    }

    function test() external pure {
        require(romanToInt("III")==3,"test1 fail");
        require(romanToInt("IV")==4,"test2 fail");
        require(romanToInt("XXVII")==27,"test3 fail");
        require(romanToInt("XIV")==14,"test4 fail");
        require(romanToInt("XV")==14,"test5 fail");
    }

}