package edu.agh.jpwp;

import java.util.Random;

public class Math {

    public static void main(String[] args) {
        System.out.println("Wyliczanie silni");
        final int factorial = 10;

        final int result = funk(1,1,factorial);

        System.out.println("Wynik " + factorial + "! = " + result);
    }

    public static final int funk(final int suma,final int nrop, final int ileop){
        if (nrop >= ileop) return suma;

        return funk(suma*nrop,nrop+1,ileop);
    }
}
