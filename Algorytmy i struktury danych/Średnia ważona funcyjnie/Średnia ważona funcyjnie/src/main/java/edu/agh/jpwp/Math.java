package edu.agh.jpwp;

import java.util.Arrays;
import java.util.Random;

public class Math {

    public static void main(String[] args) {
        System.out.println("Wyliczanie średniej ważonej z listy");
        final double values[] = {
                10.5, 2,
                5.0, 1,
                1.2, 34,
                14.3, 3,
                1.0, 2
        };

        final double dresult = weightedAverage(0.0, 0.0, values)[0];

        System.out.println("Wynik: " + dresult);
    }

    public static final double[] weightedAverage(final double currentValue, final double totalWeights, double[] values){
        if(values.length < 2) return new double[]{ currentValue };

        return weightedAverage((currentValue*totalWeights + values[0])/(totalWeights + values[1]), totalWeights + values[1], Arrays.copyOfRange(values, 2, values.length));
    }
}
