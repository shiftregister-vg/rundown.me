<g:woopraTrackingScript name="${ session?.user?.fullName() }" username="${ session?.user?.username }" email="${ session?.user?.email }" bio="${ session?.user?.bio }" />
<g:if env="production">
	<g:woopraTrackingScript name="${ session?.user?.fullName() }" username="${ session?.user?.username }" email="${ session?.user?.email }" />
</g:if>