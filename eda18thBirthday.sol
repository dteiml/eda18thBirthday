pragma solidity ^0.4.18;

import "./GnosisToken.sol";

contract eda {
	// 1491955200 = 12. 4. 2017
	uint edaBirthday = 1491955200;

	address dom = 0xC5c83A12501C6470B002E54409B024C02624AaAA;
	address majaALubo = 0x67f38b53c3aD78F045F75C805deFeA7086711e75;

	address GNO = 0x6810e776880C02933D47DB1b9fc05908e5386b96;

	bool domEarlyWithdrawApproval;
	bool majaALuboEarlyWithdrawApproval;

	function withdrawEarly(address to)
		public
	{
		if (msg.sender == dom) {
			if (majaALuboEarlyWithdrawApproval == true) {
				withdraw(to);
			} else {
				domEarlyWithdrawApproval = true;
			}
		} else if (msg.sender == majaALubo) {
			if (domEarlyWithdrawApproval == true) {
				withdraw(to);
			} else {
				majaALuboEarlyWithdrawApproval = true;
			}
		}
	}

	function withdraw(address to)
		internal
	{
		uint balance = GnosisToken(GNO).balanceOf(this);
		GnosisToken(GNO).transfer(to, balance);
	}

	function withdrawAfter18Years(address to)
		public
	{
		// 567,648,000 = 18 years in s	
		require(now >= edaBirthday + 567648000);

		require(msg.sender == dom || msg.sender == majaALubo);

		withdraw(to);
	}
}