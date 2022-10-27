// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract Udemy {
    string public name = "Udemy Web3";
    uint public coursesCount = 0;
    mapping(uint => Course) public courses;


    struct Course {
        uint id;
        string title;
        string body;
        string thumbnail;
        address payable author;
        Video[] videos;
    }

    struct Video {
        uint id;
        string title;
        string hash;
    }

    event CourseCreated(
        uint id,
        string title,
        string body,
        string thumbnail,
        address payable author
    );

    function createCourse(string memory _title, string memory _body, string memory _thumbnail, string[] memory _videos, string[] memory _videosTitle) public {
        // Require valid title
        require(bytes(_title).length > 0);
        // Require valid body
        require(bytes(_body).length > 0);
        // Require valid thumbnail
        require(bytes(_thumbnail).length > 0);
        // Require valid videos
        require(_videos.length > 0);
        // Require valid author
        require(msg.sender != address(0x0));
        // Increment course count
        uint256 videosAmount = _videos.length;
        coursesCount ++;
        // Create the course
        for (uint i = 0; i < videosAmount; i ++) {
            courses[coursesCount].videos.push(Video(
                    i + 1,
                    _videosTitle[i],
                    _videos[i]
                ));
        }
        courses[coursesCount].title = _title;
        courses[coursesCount].body = _body;
        courses[coursesCount].thumbnail = _thumbnail;
        courses[coursesCount].author = payable(msg.sender);
        courses[coursesCount].id = coursesCount;
        // Trigger an event
        emit CourseCreated(coursesCount, _title, _body, _thumbnail, payable(msg.sender));
    }


    function getAllCourses() public view returns (Course[] memory) {
        Course[] memory _courses = new Course[](coursesCount);
        for (uint i = 0; i < coursesCount; i++) {
            _courses[i] = courses[i + 1];
        }
        return _courses;
    }
}