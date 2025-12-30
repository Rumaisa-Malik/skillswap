package controller;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class LoginServletTest {

    @Test
    public void testValidUserId() {
        Integer userId = 1;
        assertNotNull(userId);
        assertEquals(1, userId);
    }

    @Test
    public void testInvalidUserId() {
        Integer userId = null;
        assertNull(userId);
    }
}
