clear all;
close all;

srebro_raw=[23.97
23.88
23.54
24.03
23.86
23.74
23.59
23.96
24.13
22.99
23.23
23.07
23.88
23.69
23.35
23.48
23.10
22.72
22.18
22.25
23.16
22.70
22.35
21.22
20.93
21.61
21.49
21.58
21.09
20.86
20.94
20.96
21.43
21.59
21.93
21.71
21.61
21.04
21.39
20.77
20.85
19.45
19.16
19.63
19.16
19.26
19.55
19.61
19.33
19.30
19.42
18.61
18.41
18.77
18.66
18.28
18.87
19.06
19.12
19.64
20.13
20.60
20.68
21.02
20.77
19.03
18.91
18.84
18.39
18.44
18.88
19.67
19.47
19.29
19.54
19.61
18.97
19.65
19.35
19.85
18.84
18.58
18.45
17.98
18.22
18.06
17.83
17.91
18.40
18.79
18.91
19.20
19.12
19.09
18.96
19.06
19.51
19.82
20.13
20.25
20.82
20.28
20.60
20.52
20.71
19.90
20.21
19.99
19.87
20.33
20.36
19.95
19.15
18.68
18.40
18.61
18.82
18.68
18.77
18.71
18.71
18.45
19.13
18.90
19.10
19.32
19.26
19.18
19.24
19.99
19.89
20.27
20.75
20.82
21.16
21.15
21.01
21.39
21.62
21.60
21.68
21.87
21.72
21.10
21.13
21.89
21.65
22.05
22.24
22.04
21.93
22.38
21.79
21.55
21.93
22.12
22.02
21.99
22.13
21.76
21.75
21.91
21.34
21.63
21.60
21.11
20.82
21.54
21.27
21.82
22.36
22.47
23.01
22.60
22.64
22.76
23.18
23.33
23.60
23.69
24.14
24.63
25.17
25.11
25.86
25.32
25.67
25.67
25.40
25.10
24.78
24.64
24.41
24.28
24.52
24.62
24.80
24.90
24.74
24.94
25.53
25.58
25.18
24.76
25.23
24.96
25.40
25.15
24.94
25.08
25.85
25.90
25.64
26.46
25.70
25.74
25.10
25.25
25.37
24.42
24.25
24.20
24.55
24.14
24.01
23.94
23.84
23.59
23.38
23.88
23.57
23.18
23.30
23.20
23.04
22.50
22.42
22.62
22.63
22.48
22.47
22.75
23.59
23.90
23.95
24.29
24.39
24.09
23.47
23.02
22.96
23.06
23.13
22.76
22.50
22.37
22.19
22.78
23.06
22.92];

zloto_raw=[1823.86
1815.00
1805.86
1812.46
1801.94
1798.58
1793.30
1814.94
1817.28
1787.33
1793.13
1776.57
1807.69
1809.72
1782.11
1797.35
1789.33
1787.13
1771.06
1769.28
1798.03
1802.34
1773.48
1748.84
1741.31
1754.60
1755.53
1752.24
1741.21
1738.57
1751.04
1759.93
1773.94
1780.82
1769.57
1770.78
1752.30
1706.56
1711.60
1674.60
1681.30
1629.77
1633.88
1646.87
1632.51
1644.70
1661.89
1667.29
1652.82
1651.80
1657.60
1627.04
1627.28
1652.42
1650.67
1644.16
1663.59
1674.50
1663.98
1670.29
1694.70
1711.80
1718.41
1725.65
1700.96
1660.60
1664.40
1656.48
1628.84
1627.95
1643.90
1672.80
1667.23
1666.47
1675.89
1675.23
1662.54
1697.65
1702.16
1725.42
1717.32
1710.74
1716.64
1703.50
1714.02
1712.50
1697.50
1708.84
1723.41
1739.73
1738.10
1756.69
1751.07
1746.16
1735.32
1747.00
1758.54
1765.04
1775.56
1778.57
1801.89
1789.19
1791.78
1794.16
1789.26
1774.97
1793.47
1763.71
1756.78
1772.11
1766.16
1755.05
1738.87
1718.02
1719.06
1727.45
1718.55
1695.50
1710.01
1708.26
1707.27
1711.78
1732.08
1725.42
1733.39
1742.35
1741.94
1740.06
1769.48
1809.16
1810.46
1806.67
1818.93
1818.44
1823.61
1827.54
1824.70
1836.67
1831.39
1839.17
1840.25
1851.01
1833.90
1810.99
1820.98
1871.61
1847.09
1852.82
1853.62
1839.64
1851.10
1869.84
1846.05
1836.44
1852.52
1853.48
1853.04
1854.09
1867.44
1853.94
1846.53
1842.17
1816.19
1814.62
1826.49
1811.09
1820.70
1854.14
1833.65
1854.73
1883.86
1874.40
1894.08
1868.47
1863.28
1896.95
1895.60
1885.73
1906.63
1899.54
1931.96
1951.27
1956.95
1949.86
1977.34
1974.80
1973.30
1977.25
1966.04
1952.97
1947.57
1933.08
1923.91
1920.69
1931.59
1924.80
1936.78
1933.98
1916.47
1924.15
1958.39
1959.36
1946.21
1919.54
1935.53
1921.49
1944.05
1926.98
1918.31
1952.36
1987.99
1995.61
1990.08
2043.83
1998.79
1970.68
1934.96
1929.16
1942.43
1906.41
1889.18
1906.45
1910.86
1898.27
1909.53
1897.36
1900.09
1869.85
1853.08
1871.16
1858.69
1826.92
1832.75
1825.99
1822.10
1807.95
1805.76
1807.90
1800.77
1797.92
1792.11
1797.32
1822.01
1849.68
1843.57
1834.58
1839.01
1838.58
1814.33
1819.22
1817.43
1821.16
1825.36
1820.88
1801.52
1796.41
1791.61
1810.28
1813.88
1804.27];

%przedział czasowy 0-260
pocz=1;
koniec=259;

%ilość dodatkowych dni
ekst=10;

t1=[pocz:1:koniec]';
zloto=zloto_raw(pocz:koniec);
srebro=srebro_raw(pocz:koniec);



f = @(a,b,c,x) a.*(1-exp(-(x.*b).^c));
obj_fun_zl = @(params) norm(f(params(1), params(2), params(3),t1)-zloto);
obj_fun_sr = @(params) norm(f(params(1), params(2), params(3),t1)-srebro);

wynik_zloto = fminsearch(obj_fun_zl, [zloto(end),0,1]);
wynik_srebro = fminsearch(obj_fun_sr, [srebro(end),0,1]);
a_wz = wynik_zloto(1);
b_wz = wynik_zloto(2);
c_wz = wynik_zloto(3);

a_ws = wynik_srebro(1);
b_ws = wynik_srebro(2);
c_ws = wynik_srebro(3);
% y_fit = f(a_sol, b_sol,c_sol, t1);

% extrapolation 
t_ekstr = [pocz:1:koniec+ekst]';
y_zloto = f(a_wz, b_wz,c_wz, t_ekstr);
y_zloto(1)=1730;

y_srebro = f(a_ws, b_ws,c_ws, t_ekstr);
% 
% y_zloto(1)=zloto(1);
% y_srebro(1)=srebro(1);


figure;
plot(t1, zloto, '+', 'MarkerSize', 10, 'LineWidth', 2)
hold on
plot(t_ekstr, y_zloto);grid on
xlabel('time t');
ylabel('y');