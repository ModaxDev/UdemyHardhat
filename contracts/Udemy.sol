pragma solidity ^0.8.9;

contract Udemy {
    string public name = "Udemy Web3";
    uint public coursesCount = 0;
    mapping(uint => Course) public courses;

    struct Course {
        uint id;
        string title;
        string body;
        address payable author;
    }

    event CourseCreated(
        uint id,
        string title,
        string body,
        address payable author
    );

    function createCourse(string memory _title, string memory _body) public {
        // Require valid title
        require(bytes(_title).length > 0);
        // Require valid body
        require(bytes(_body).length > 0);
        // Require valid author
        require(msg.sender != address(0x0));
        // Increment course count
        coursesCount ++;
        // Create the course
        courses[coursesCount] = Course(coursesCount, _title, _body, payable(msg.sender));
        // Trigger an event
        emit CourseCreated(coursesCount, _title, _body, payable(msg.sender));
    }
}
