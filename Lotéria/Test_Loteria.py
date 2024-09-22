from unittest import TestCase
from Loteria import prijat_cislo, stav_sportku, losovanie_loterie


class Test(TestCase):
    def test_prijat_cislo(self):
        # simulované vstupy od uživateľa (inputy)
        test_input = ["0", "100", "a", "5", "13"]
        # simulované už zvolené čísla
        test_vybrane_cisla = [1, 5]
        # pre každý simulovaný vstup urobím kontrolu a uložím
        zkontrolovane = []
        for inp in test_input:
            zkontrolovane.append(prijat_cislo(inp, test_vybrane_cisla))
        # očekávaný výsledek
        expected = [False, False, False, False, True]
        self.assertEqual(zkontrolovane, expected)

    def test_losovanie_loterie(self):
        losovanie = losovanie_loterie()
        dlzka = len(losovanie)
        # test či dostanem spät 6 čísiel?
        self.assertEqual(dlzka, 6)
        dlzka_unikat = len(set(losovanie))
        # dostanu zpět 6 unikátních čísel?
        self.assertEqual(dlzka_unikat, 6)
