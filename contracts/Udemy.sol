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
    }

    event CourseCreated(
        uint id,
        string title,
        string body,
        string thumbnail,
        address payable author
    );

    function createCourse(string memory _title, string memory _body, string memory _thumbnail ) public {
        // Require valid title
        require(bytes(_title).length > 0);
        // Require valid body
        require(bytes(_body).length > 0);
        // Require valid thumbnail
        require(bytes(_thumbnail).length > 0);
        // Require valid author
        require(msg.sender != address(0x0));
        // Increment course count
        coursesCount ++;
        // Create the course
        courses[coursesCount] = Course(coursesCount, _title, _body, _thumbnail, payable(msg.sender));
        // Trigger an event
        emit CourseCreated(coursesCount, _title, _body,_thumbnail, payable(msg.sender));
    }




    function getAllCourses() public view returns (Course[] memory) {
        Course[] memory _courses = new Course[](coursesCount);
        for (uint i = 0; i < coursesCount; i++) {
            _courses[i] = courses[i + 1];
        }
        return _courses;
    }
}