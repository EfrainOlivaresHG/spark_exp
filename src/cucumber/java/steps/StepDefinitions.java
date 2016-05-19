package steps;

import com.hgdata.Main;
import cucumber.api.java.en.*;

import static org.junit.Assert.*;

/**
 * This is where all the steps are defined for cucumber
 */
public class StepDefinitions {

    private Main main;
    private String greeting;

    @Given("^I have the Main$")
    public void iHaveTheMain() {
        main = new Main();
    }

    @When("^I get the greeting$")
    public void iGetTheGreeting() {
        greeting = main.getGreeting();
    }

    @Then("^it should be \"([^\"]*)\"$")
    public void itShouldBe(String value) {
        assertEquals(value, greeting);
    }

}
