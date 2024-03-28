package edu.agh.jpwp;

import java.util.Random;

public class Math {

    public static void main(String[] args) {
        System.out.println("Wyliczanie liczby pi metodą Monte Carlo");

        int iterations = 1000; // liczba iteracji algorytmu
        Random rand = new Random(); // generator liczb losowych

        final int[] result = funk(rand, iterations, 0,0);

        // obliczamy przybliżoną wartość liczby pi
        double pi = 4.0 * result[0] / (result[0]+result[1]);

        // wyświetlamy wynik
        System.out.println("Przybliżona wartość liczby pi: " + pi);
    }

    public static final int[] funk(final Random rand, final int suma, final int ins, final int outs){
        if (suma<ins + outs) return new int[]{ ins, outs };

        double x = rand.nextDouble();
        double y = rand.nextDouble();
        double dist = java.lang.Math.sqrt(x * x + y * y);

        if (dist < 1.0){
            return funk(rand,suma,ins+1,outs);
        }

        return funk(rand,suma,ins,outs+1);
    }
}
