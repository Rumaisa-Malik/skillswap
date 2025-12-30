package controller;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

public class LearnerSessionsServletTest {

    @Test
    public void testSessionsListNotEmpty() {
        List<String> sessions = new ArrayList<>();
        sessions.add("Java Basics Session");

        assertNotNull(sessions);
        assertFalse(sessions.isEmpty());
        assertEquals(1, sessions.size());
    }

    @Test
    public void testSessionsListEmpty() {
        List<String> sessions = new ArrayList<>();

        assertNotNull(sessions);
        assertTrue(sessions.isEmpty());
    }
}
