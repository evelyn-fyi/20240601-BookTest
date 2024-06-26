@IsTest
public with sharing class AccountTest {
    @IsTest
    static void testServiceWrapperReturn() {
        List<Account> acctsToInsert = new List<Account>();
        for(Integer ii = 0; ii < 10; ii++) {
            Account acct = new Account(Name = 'Account ' + ii);
            acct.AnnualRevenue = ii * 100000;
            acct.Museum_Office__Latitude__s = 37.790197;
            acct.Museum_Office__Longitude__s = -122.396879;
            acctsToInsert.add(acct);
        }

        insert acctsToInsert;

        Test.startTest();
            String resultString = AccountService.returnAccountWrapperList();
        Test.stopTest();

        for(Integer jj = 0; jj < 10; jj++) {
            Assert.isTrue(resultString.contains('Account ' + jj), 'Verify that the resultString contains each of the inserted accounts. Account ' + jj);
        }
    }

    @IsTest
    static void testSelectortopTenAccounts() {
        List<Account> acctsToReturn = new List<Account>();
        for(Integer ii = 0; ii < 10; ii++) {
            Account acct = new Account(Name = 'Account ' + ii);
            acct.AnnualRevenue = ii * 100000;
            acct.Museum_Office__Latitude__s = 37.790197;
            acct.Museum_Office__Longitude__s = -122.396879;
            acctsToReturn.add(acct);
        }

        insert acctsToReturn;

        Test.startTest();
            List<AccountSelector.AccountWrapper> resultWrappers = new AccountSelector().topTenAccountsByRevenue();
        Test.stopTest();

        for(Integer jj = 0; jj < 10; jj++) {
            Assert.isTrue(resultWrappers[jj].Name == 'Account ' + (9 - jj), 'Verify that the resultString contains each of the inserted accounts, and that they are sorted in the correct order. Account ' + jj);
        }
    }

    @IsTest
    static void testMockedSelectortopTenAccounts() {
        AccountSelector mockSelector = (AccountSelector)Util_Mocker.createMock(AccountSelector.class);

        Test.startTest();
            List<AccountSelector.AccountWrapper> resultWrappers = mockSelector.topTenAccountsByRevenue();
        Test.stopTest();

        for(Integer jj = 0; jj < 10; jj++) {
            Assert.isTrue(resultWrappers[jj].Name == 'Account ' + (9 - jj), 'Verify that the resultString contains each of the inserted accounts, and that they are sorted in the correct order. Account ' + jj);
        }
    }
}