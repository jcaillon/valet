# Valet automated tests

In this directory, you can find the tests that are run automatically by Valet. They are used to ensure that the core functionalities of Valet work as expected.

Each subfolder represents a specific **test suite**, and the `.sh` files within those folders contain the actual tests.

Test assertions are done using approval testing, which means that the output of the tests is compared to a previously approved output. If the output changes, the test will fail, and you will need to approve the new output if it is correct.

You can find each test outputs in the `results.approved.md` file for each test suite.

Learn more about tests in the Valet documentation: <https://jcaillon.github.io/valet/docs/new-tests/>.
