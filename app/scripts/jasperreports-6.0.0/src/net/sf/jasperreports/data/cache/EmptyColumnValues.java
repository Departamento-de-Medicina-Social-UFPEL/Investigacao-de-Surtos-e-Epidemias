/*
 * JasperReports - Free Java Reporting Library.
 * Copyright (C) 2001 - 2014 TIBCO Software Inc. All rights reserved.
 * http://www.jaspersoft.com
 *
 * Unless you have purchased a commercial license agreement from Jaspersoft,
 * the following license terms apply:
 *
 * This program is part of JasperReports.
 *
 * JasperReports is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * JasperReports is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with JasperReports. If not, see <http://www.gnu.org/licenses/>.
 */
package net.sf.jasperreports.data.cache;

import java.io.ObjectStreamException;
import java.io.Serializable;

import net.sf.jasperreports.engine.JRConstants;

/**
 * @author Lucian Chirita (lucianc@users.sourceforge.net)
 * @version $Id: EmptyColumnValues.java 7197 2014-08-27 11:59:50Z teodord $
 */
public class EmptyColumnValues implements ColumnValues, Serializable
{

	private static final long serialVersionUID = JRConstants.SERIAL_VERSION_UID;

	private static final EmptyColumnValues INSTANCE = new EmptyColumnValues();
	
	public static EmptyColumnValues instance()
	{
		return INSTANCE;
	}
	
	private Object readResolve() throws ObjectStreamException
	{
		return INSTANCE;
	}
	
	public int size()
	{
		return 0;
	}

	public ColumnValuesIterator iterator()
	{
		return EmptyColumnValuesIterator.instance();
	}

}

class EmptyColumnValuesIterator implements ColumnValuesIterator
{

	private static final EmptyColumnValuesIterator INSTANCE = new EmptyColumnValuesIterator();
	
	public static ColumnValuesIterator instance()
	{
		return INSTANCE;
	}

	public void moveFirst()
	{
		// NOP
	}

	public boolean next()
	{
		return false;
	}

	public Object get()
	{
		throw new IllegalStateException();
	}
	
}