// This class generates source code based on the grammar implemented in it.
// The Source code goes to input.mol and used rules goes to rules.par

import java.io.*;
import java.util.Random;

public class Test
{
	public static BufferedWriter mol;
	public static BufferedWriter rules;
	public static Random rand;
	
	public static void main(String[] args) throws IOException
	{
		mol = new BufferedWriter(new FileWriter("./input.mol"));
		rules = new BufferedWriter(new FileWriter("./rules.par"));
		rand = new Random();
		
		expr();
		
		mol.flush();
		mol.close();
		rules.flush();
		rules.close();
	}

	private static void loc() throws IOException
	{
		mol.write("id");
	}

	private static void expr() throws IOException
	{
		int chance = rand.nextInt(10);
		if (chance >= 0 && chance < 4)
		{
			loc();
		}
		if (chance >= 4 && chance < 5)
		{
			unop();
			mol.write(" ");
			expr();
		}
		if (chance >= 5 && chance < 8)
		{
			expr();
			mol.write(" ");
			binop();
			mol.write(" ");
			expr();
		}
		if (chance >= 8 && chance < 10)
		{
			mol.write("(");
			expr();
			mol.write(")");
		}
	}
	
	private static void binop() throws IOException
	{
		int chance = rand.nextInt(12);
		switch (chance)
		{
		case 0:
			mol.write("or");
			break;
		case 1:
			mol.write("and");
			break;
		case 2:
			mol.write("=");
			break;
		case 3:
			mol.write("!=");
			break;
		case 4:
			mol.write("<");
			break;
		case 5:
			mol.write(">");
			break;
		case 6:
			mol.write("<=");
			break;
		case 7:
			mol.write(">=");
			break;
		case 8:
			mol.write("+");
			break;
		case 9:
			mol.write("-");
			break;
		case 10:
			mol.write("*");
			break;
		case 11:
			mol.write("/");
			break;
		}
	}

	private static void unop() throws IOException
	{
		int chance = rand.nextInt(2);
		if (chance == 0)
		{
			mol.write("-");
		}
		if (chance > 0)
		{
			mol.write("not");
		}
	}
}

