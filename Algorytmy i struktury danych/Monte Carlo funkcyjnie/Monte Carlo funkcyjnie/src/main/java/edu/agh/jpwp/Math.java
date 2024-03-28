package edu.agh.jpwp;

import java.util.Arrays;
import java.util.Random;

public class Math {

    public static void main(String[] args) {
        System.out.println("Wyliczanie liczby pi metodą Monte Carlo");

        int iterations = 1000; // liczba iteracji algorytmu
        final Random rand = new Random(); // generator liczb losowych

        final int[] mtResults = stepMonteCarlo(0, 0, iterations, rand);

        // obliczamy przybliżoną wartość liczby pi
        double pi = 4.0 * mtResults[0] / (mtResults[0] + mtResults[1]);

        // wyświetlamy wynik
        System.out.println("Przybliżona wartość liczby pi: " + pi);
    }
    public static final int[] stepMonteCarlo(final int currentInside, final int currentOutside, final int totalTarget, final Random rand){
        // inside + outside = total, sprawdzamy czy przerwać algorytm
        if(currentInside + currentOutside > totalTarget) return new int[]{ currentInside, currentOutside };

        double x = rand.nextDouble();
        double y = rand.nextDouble();
        double dist = java.lang.Math.sqrt(x * x + y * y);
        if (dist < 1.0) {
            // Punkt w okręgu, dodajemy +1 do inside
            return stepMonteCarlo(currentInside + 1, currentOutside, totalTarget, rand);
        }

        // Punkt poza okręgiem, dodajemy +1 do outside
        return stepMonteCarlo(currentInside, currentOutside + 1, totalTarget, rand);
    }
}
