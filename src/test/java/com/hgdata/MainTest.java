package com.hgdata;

import org.junit.Test;

import static org.junit.Assert.*;

public class MainTest {

    @Test
    public void testFunction() throws Exception {
        Main main = new Main();
        assertEquals("Hello World", main.getGreeting());
    }

}
