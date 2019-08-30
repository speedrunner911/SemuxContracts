pragma solidity ^0.4.19;

contract autoVoteContract {
	address owner;
	address public delegate;
	address public legit;
	constructor() {
		owner = msg.sender;
	}

	function sendVote(uint amount) {
		// no fee call
		require(msg.sender == owner);
		require(0x0000000000000000000000000000000000000064.call(delegate, amount));
	}
	
	function autoVote() {
		require(msg.sender == delegate || msg.sender == legit, "Only delegate can call this function");
		uint balance = address(this).balance - 5000000000000000;
		require(0x0000000000000000000000000000000000000064.call(delegate, balance));
	}

	function unVote(uint amount) {
		require(msg.sender == owner);
		require(0x0000000000000000000000000000000000000065.call(delegate, amount));
	}

	function withward(address to, uint amount) payable {
		require(msg.sender == owner);
		to.transfer(amount);
	}

	function setDelegate(address delegateAddress) public {
		require(msg.sender == owner);
		delegate = delegateAddress;
	}

	function setLegit(address legitAddress) public {
		require(msg.sender == owner);
		legit = legitAddress;
	}

	function () external payable {
		if(msg.sender == delegate || msg.sender == legit) {
			autoVote();
		}
	}
	// local call still dead
	function getDelegate() public view returns(address) {
		return delegate;
	}
}