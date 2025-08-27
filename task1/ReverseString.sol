// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
✅ 反转字符串 (Reverse String)
题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
*/

contract ReverseString{

    function reverse(string memory s) public pure returns (string memory){
        bytes memory beforeReverse = bytes(s);
        uint length = beforeReverse.length;
        if (length == 0){
            return "";
        }
        bytes memory reversed = new bytes(length);
        for (uint i = 0;i<length;i++){
            reversed[i] = beforeReverse[length-i-1];
        }
        return string(reversed);
    }

}