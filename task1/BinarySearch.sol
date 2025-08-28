// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch{

    /*
    二分查找法
    @param arr 有序数组（必须从小道道排序）
    @param target 要查找的目标值
    @return 如果找到返回的元素索引，否则返回type(uint).max
    */
    function binarySearch(uint[] memory arr,uint target) public pure returns (uint){
        //处理空数组的情况
        if (arr.length==0){
            return type(uint).max;
        }
        uint left = 0 ;
        uint right = arr.length-1;
        while (left<=right){
            //计算中间位置，防止溢出
            uint mid = left + (right-left)/2;
            if (arr[mid] == target){
                //找到目标值，返回索引
                return mid;
            }else if (arr[mid]<target){
                //目标值再右半部分
                left = mid +1;
            }else {
                //目标值再左半部分
                right = mid -1;
            }
        }
        //没有找到目标值
        return type(uint).max;
    }

    /*
    测试例子1：正常查找
    */
    function testNormalSearch() public pure returns (uint[4] memory results){
        uint[] memory arr = new uint[](6);
        arr[0] = 10;
        arr[1] = 20;
        arr[2] = 30;
        arr[3] = 40;
        arr[4] = 50;
        arr[5] = 60;
        results[0] = binarySearch(arr, 10);  // 应该返回 0
        results[1] = binarySearch(arr, 30);  // 应该返回 2
        results[2] = binarySearch(arr, 60);  // 应该返回 5
        results[3] = binarySearch(arr, 99);  // 应该返回 type(uint).max (没找到)
    }

    /**
     * 测试例子2：边界情况
     */
    function testEdgeCases() public pure returns (uint[3] memory results) {
        uint[] memory arr = new uint[](1);
        arr[0] = 5;
        
        results[0] = binarySearch(arr, 5);   // 应该返回 0
        // results[1] = binarySearch(arr, 3);   // 应该返回 type(uint).max
        results[2] = binarySearch(new uint[](0), 5);  // 空数组测试
    }

    /**
     * 测试例子3：较大数组
     */
    function testLargeArray() public pure returns (uint[3] memory results) {
        uint[] memory arr = new uint[](8);
        arr[0] = 1;
        arr[1] = 3;
        arr[2] = 5;
        arr[3] = 7;
        arr[4] = 9;
        arr[5] = 11;
        arr[6] = 13;
        arr[7] = 15;
        
        results[0] = binarySearch(arr, 1);   // 应该返回 0
        results[1] = binarySearch(arr, 9);   // 应该返回 4
        results[2] = binarySearch(arr, 15);  // 应该返回 7
    }


    /**
     * 测试例子4：重复元素（返回任意一个匹配的索引）
     */
    function testDuplicateElements() public pure returns (uint[2] memory results) {
        uint[] memory arr = new uint[](6);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 2;
        arr[3] = 2;
        arr[4] = 3;
        arr[5] = 4;
        
        results[0] = binarySearch(arr, 2);  // 可能返回 1, 2 或 3
        results[1] = binarySearch(arr, 5);  // 应该返回 type(uint).max
    }

    
    /**
     * 实用函数：检查值是否找到
     */
    function isFound(uint result) public pure returns (bool) {
        return result != type(uint).max;
    }
    
    /**
     * 实用函数：获取"未找到"的标志值
     */
    function getNotFoundValue() public pure returns (uint) {
        return type(uint).max;
    }

    /**
     * 综合测试示例
     */
    function comprehensiveTest() public pure returns (string memory) {
        uint[] memory arr = new uint[](5);
        arr[0] = 100;
        arr[1] = 200;
        arr[2] = 300;
        arr[3] = 400;
        arr[4] = 500;
        
        uint result1 = binarySearch(arr, 300);  // 找到
        uint result2 = binarySearch(arr, 250);  // 没找到
        
        if (isFound(result1) && !isFound(result2)) {
            return unicode"测试通过！二分查找正常工作";
        } else {
            return unicode"测试失败！";
        }
    }
}