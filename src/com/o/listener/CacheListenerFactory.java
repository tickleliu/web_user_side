package com.o.listener;

import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import net.sf.ehcache.event.CacheEventListener;
import net.sf.ehcache.event.CacheEventListenerFactory;

public class CacheListenerFactory extends CacheEventListenerFactory implements ApplicationContextAware{
	
	public ApplicationContext getContext() {
		return context;
	}

	public void setContext(ApplicationContext context) {
		this.context = context;
	}

	private ApplicationContext context;

	@Override
	public CacheEventListener createCacheEventListener(Properties arg0) {
		// TODO Auto-generated method stub
//		String beanNameString = arg0.getProperty("bean");
		return new MyCacheEventListener();
	}

	@Override
	public void setApplicationContext(ApplicationContext arg0)
			throws BeansException {
		// TODO Auto-generated method stub
		this.context = arg0;
	}

}
