// This class generates source code based on the grammar implemented in it.
// The Source code goes to input.mol and used rules goes to rules.par

import java.io.*;

public class Test
{
	public static BufferedWriter mol;
	public static BufferedWriter rules;
	
	public static void main(String[] args) throws IOException
	{
		mol = new BufferedWriter(new FileWriter("./input.mol"));
		rules = new BufferedWriter(new FileWriter("./rules.par"));
		
		mol.write("hello ");
		id();
		rules.write("Rule 1");
		rules.newLine();
		
		mol.flush();
		mol.close();
		rules.flush();
		rules.close();
	}

	private static void id() throws IOException
	{
		mol.write("homie");
		mol.newLine();
		rules.write("Rule 2");
		rules.newLine();
	}

}

