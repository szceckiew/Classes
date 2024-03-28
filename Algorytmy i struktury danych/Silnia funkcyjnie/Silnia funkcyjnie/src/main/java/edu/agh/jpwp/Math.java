package edu.agh.jpwp;

import java.util.Arrays;
import java.util.Random;

public class Math {

    public static void main(String[] args) {
        System.out.println("Wyliczanie silni");
        final int factorial_target = 10;

        final int result = factorial(1, 1, factorial_target);

        System.out.println("Wynik " + factorial_target + "! = " + result);
    }

    public static final int factorial(final int currentValue, final int levelNow, final int levelTarget){
        if(levelNow >= levelTarget) return currentValue;

        return factorial(currentValue * levelNow, levelNow + 1, levelTarget);
    }
}
