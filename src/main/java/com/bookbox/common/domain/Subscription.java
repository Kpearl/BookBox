package com.bookbox.common.domain;

/**
 * @file com.bookbox.common.domain.Subscription.java
 * @brief Subscription domain
 * @detail 창작작품(creation)
 * @author HJ
 * @date 2017.10.11
 */

public class Subscription {

	//Field
	private String subscriptionContent;
	private boolean doSubscription;

	public Subscription() {
		// TODO Auto-generated constructor stub
	}

	public String getSubscriptionContent() {
		return subscriptionContent;
	}

	public void setSubscriptionContent(String subscriptionContent) {
		this.subscriptionContent = subscriptionContent;
	}

	public boolean isDoSubscription() {
		return doSubscription;
	}

	public void setDoSubscription(boolean doSubscription) {
		this.doSubscription = doSubscription;
	}

	@Override
	public String toString() {
		return "Subscription [subscriptionContent=" + subscriptionContent + ", doSubscription=" + doSubscription + "]";
	}
}
