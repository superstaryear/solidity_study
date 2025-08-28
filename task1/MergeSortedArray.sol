// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray{

    /*
        合并两个有序数据
        a 第一个有序数组（必须从小到大排序)
        b 第二个有序数据(必须从小到大排序)
        工作原理：像拉链一样，比较两个数组的当前元素，选择较小的放入结果
    */

    function merge(uint[] memory a,uint[] memory b) public pure returns (uint[] memory){
        //创建结果数组，大小为两个数组长度之和
        uint[] memory result = new uint[](a.length+b.length);
        //初始化三个指针
        uint i = 0;  //指向a数组的当前元素
        uint j = 0;  //指向b数组的当前元素
        uint k = 0;  //指向结果数组的当前位置
        //同时遍历两个数组，选择较小的元素放入结果
        while(i<a.length&&j<b.length){
            if(a[i]<= b[j]){
                result[k] = a[i];
                i++;
            }else {
                result[k] = b[j];
                j++;
            }
            k++;
        }
        
        //如果数组a还有剩余元素，全部放入结果
        while(i<a.length){
            result[k] = a[i];
            i++;
            k++;
        }
          
        //如果数组b还有剩余元素，全部放入结果
        while(j<b.length){
            result[k] = b[j];
            j++;
            k++;
        }
       return result;
    }

        
    /**
     * 测试示例1：正常情况
     */
    function testExample1() public pure returns (uint[] memory) {
        uint[] memory arr1 = new uint[](3);
        arr1[0] = 1;
        arr1[1] = 3;
        arr1[2] = 5;
        
        uint[] memory arr2 = new uint[](3);
        arr2[0] = 2;
        arr2[1] = 4;
        arr2[2] = 6;
        
        return merge(arr1, arr2);
        // 预期结果: [1, 2, 3, 4, 5, 6]
    }
    
    /**
     * 测试示例2：数组长度不同
     */
    function testExample2() public pure returns (uint[] memory) {
        uint[] memory arr1 = new uint[](2);
        arr1[0] = 1;
        arr1[1] = 2;
        
        uint[] memory arr2 = new uint[](4);
        arr2[0] = 3;
        arr2[1] = 4;
        arr2[2] = 5;
        arr2[3] = 6;
        
        return merge(arr1, arr2);
        // 预期结果: [1, 2, 3, 4, 5, 6]
    }
    
    /**
     * 测试示例3：包含重复元素
     */
    function testExample3() public pure returns (uint[] memory) {
        uint[] memory arr1 = new uint[](3);
        arr1[0] = 1;
        arr1[1] = 2;
        arr1[2] = 2;
        
        uint[] memory arr2 = new uint[](3);
        arr2[0] = 2;
        arr2[1] = 3;
        arr2[2] = 4;
        
        return merge(arr1, arr2);
        // 预期结果: [1, 2, 2, 2, 3, 4]
    }
    
    /**
     * 测试示例4：一个数组为空
     */
    function testExample4() public pure returns (uint[] memory) {
        uint[] memory arr1 = new uint[](0);  // 空数组
        
        uint[] memory arr2 = new uint[](3);
        arr2[0] = 1;
        arr2[1] = 2;
        arr2[2] = 3;
        
        return merge(arr1, arr2);
        // 预期结果: [1, 2, 3]
    }
    
    /**
     * 测试示例5：两个数组都为空
     */
    function testExample5() public pure returns (uint[] memory) {
        uint[] memory arr1 = new uint[](0);
        uint[] memory arr2 = new uint[](0);
        
        return merge(arr1, arr2);
        // 预期结果: 空数组
    }
    
    /**
     * 自定义测试：你可以修改这个函数来测试自己的数组
     */
    function customTest(uint[] memory customArr1, uint[] memory customArr2) public pure returns (uint[] memory) {
        return merge(customArr1, customArr2);
    }
}