// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
✅ 创建一个名为Voting的合约，包含以下功能：
一个mapping来存储候选人的得票数
一个vote函数，允许用户投票给某个候选人
一个getVotes函数，返回某个候选人的得票数
一个resetVotes函数，重置所有候选人的得票数
*/

contract Voting {

    //mapping来存储候选人的得票数
    mapping(string candidate => uint voteNum) private voteMap;
    //记录所有候选人 方便重置选票
    string[] private  allCandidates;
    mapping(string candidate => bool exist) private candidateExists;

    //定义投票事件 
    event VoteEvent(address indexed voter,string candidate, uint voteNum);
    //定义候选人添加事件
    event CandidateAdd(string candidate);
    //定义候选人选票重置事件
    event votesReset();


    //vote函数，允许用户投票给某个候选人
    function vote(string calldata candidate) public {
        if (!candidateExists[candidate]) {
            allCandidates.push(candidate);
            candidateExists[candidate] = true;
            emit CandidateAdd(candidate);
        }
        voteMap[candidate] += 1;
        emit VoteEvent(msg.sender, candidate, voteMap[candidate]);
    }

    //返回某个候选人的得票数
    function getVotes(string calldata candidate) public view returns (uint) {
        return voteMap[candidate];
    }

    //重置所有候选人的得票数
    function resetVotes() public {
        uint length = allCandidates.length;
        for (uint i=0; i<length; i++) 
        {
            voteMap[allCandidates[i]] = 0;
        }
        delete allCandidates;
        emit votesReset();
    }
       
}